import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const _apiUrlOverride = String.fromEnvironment('API_URL');

/// Адрес сервера: `--dart-define=API_URL=...`, иначе локальный сервер.
Uri defaultApiUrl() {
  if (_apiUrlOverride.isNotEmpty) return Uri.parse(_apiUrlOverride);
  // Android-эмулятор видит компьютер по адресу 10.0.2.2.
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) return Uri.parse('http://10.0.2.2:8000');
  return Uri.parse('http://127.0.0.1:8000');
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

/// 409: поездка противоречит уже сохранённой [existing].
class TripConflictException extends ApiException {
  const TripConflictException(super.message, {required this.code, required this.existing}) : super(statusCode: 409);

  /// `trip_overlap` — пересечение по времени, `id_conflict` — тот же id с другими данными.
  final String code;
  final Trip existing;
}

class CreateTripResult {
  const CreateTripResult(this.trip, {required this.created});

  final Trip trip;

  /// false — сервер уже знал эту поездку и вернул сохранённую (дубль не создан).
  final bool created;
}

class DiaryApi {
  DiaryApi({required this.baseUrl, http.Client? client}) : _client = client ?? http.Client();

  final Uri baseUrl;
  final http.Client _client;
  static const _timeout = Duration(seconds: 10);

  Future<List<DayInfo>> fetchDays() async {
    final json = await _send(() => _client.get(_url('/api/days'))) as List;
    return [for (final d in json) DayInfo.fromJson(d as Map<String, dynamic>)];
  }

  Future<DayReport> fetchDay(DateTime day) async {
    final json = await _send(() => _client.get(_url('/api/days/${formatIsoDate(day)}')));
    return DayReport.fromJson(json as Map<String, dynamic>);
  }

  Future<CreateTripResult> createTrip(NewTrip trip) async {
    late int status;
    final json = await _send(() async {
      final response = await _client.post(
        _url('/api/trips'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(trip.toJson()),
      );
      status = response.statusCode;
      return response;
    });
    return CreateTripResult(Trip.fromJson(json as Map<String, dynamic>), created: status == 201);
  }

  void close() => _client.close();

  Uri _url(String path) => baseUrl.resolve(path);

  Future<Object?> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request().timeout(_timeout);
    } on TimeoutException {
      throw const ApiException('Сервер не ответил вовремя');
    } on http.ClientException {
      throw const ApiException('Нет связи с сервером');
    }

    Object? body;
    try {
      body = response.bodyBytes.isEmpty ? null : jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      body = null;
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body == null) throw const ApiException('Сервер вернул некорректный ответ');
      return body;
    }

    final detail = body is Map<String, dynamic> ? body['detail'] : null;
    if (response.statusCode == 409 && detail is Map<String, dynamic>) {
      throw TripConflictException(
        detail['message'] as String,
        code: detail['code'] as String,
        existing: Trip.fromJson(detail['existing'] as Map<String, dynamic>),
      );
    }
    if (response.statusCode == 422 && detail is List) {
      final reasons = detail.map((e) => (e as Map<String, dynamic>)['msg']).join('; ');
      throw ApiException('Сервер отклонил данные: $reasons', statusCode: 422);
    }
    throw ApiException('Ошибка сервера (${response.statusCode})', statusCode: response.statusCode);
  }
}
