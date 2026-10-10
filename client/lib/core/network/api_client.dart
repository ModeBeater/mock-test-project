import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

const _apiUrlOverride = String.fromEnvironment('API_URL');

/// Адрес сервера: `--dart-define=API_URL=...`, иначе локальный сервер.
Uri defaultApiBaseUrl() {
  if (_apiUrlOverride.isNotEmpty) return Uri.parse(_apiUrlOverride);
  // Android-эмулятор видит компьютер по адресу 10.0.2.2.
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) return Uri.parse('http://10.0.2.2:8000');
  return Uri.parse('http://127.0.0.1:8000');
}

final class ApiResponse {
  const ApiResponse(this.statusCode, this.body);

  final int statusCode;

  /// Разобранный JSON или null, если тело пустое.
  final Object? body;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

/// Тонкая обёртка над http: JSON, таймаут и единые исключения. Статусы разбирают data sources.
class ApiClient {
  ApiClient({required this.baseUrl, required http.Client httpClient, this.timeout = const Duration(seconds: 10)})
      : _http = httpClient;

  final Uri baseUrl;
  final Duration timeout;
  final http.Client _http;

  Future<ApiResponse> get(String path, {Map<String, String>? query}) =>
      _send(() => _http.get(_url(path, query)));

  Future<ApiResponse> post(String path, Map<String, Object?> body) => _send(
        () => _http.post(_url(path), headers: const {'Content-Type': 'application/json'}, body: jsonEncode(body)),
      );

  Uri _url(String path, [Map<String, String>? query]) =>
      baseUrl.resolve(path).replace(queryParameters: query?.isEmpty ?? true ? null : query);

  Future<ApiResponse> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request().timeout(timeout);
    } on TimeoutException {
      throw const RequestTimeoutException();
    } on http.ClientException {
      throw const NoConnectionException();
    }

    if (response.bodyBytes.isEmpty) return ApiResponse(response.statusCode, null);
    try {
      return ApiResponse(response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
    } on FormatException {
      throw const MalformedResponseException();
    }
  }
}
