import '../error/failure.dart';
import '../error/result.dart';
import 'api_exception.dart';

/// Выполняет запрос слоя data и переводит исключения в [Failure].
Future<Result<T>> guard<T>(Future<T> Function() action) async {
  try {
    return Ok(await action());
  } on NoConnectionException {
    return const Err(Failure.noConnection());
  } on RequestTimeoutException {
    return const Err(Failure.timeout());
  } on MalformedResponseException {
    return const Err(Failure.malformedResponse());
  } on UnexpectedStatusException catch (e) {
    return Err(e.statusCode == 422 ? Failure.rejected(_validationMessage(e.body)) : Failure.server(e.statusCode));
  } on FormatException {
    return const Err(Failure.malformedResponse());
  } on TypeError {
    // Ответ не той формы: `json['x'] as int` и т.п.
    return const Err(Failure.malformedResponse());
  }
}

/// Текст из ответа 422 FastAPI: `{"detail": [{"msg": ...}, ...]}`.
String _validationMessage(Object? body) {
  final detail = body is Map<String, dynamic> ? body['detail'] : null;
  if (detail is List) {
    return detail.map((e) => e is Map<String, dynamic> ? e['msg'] : e).join('; ');
  }
  return 'invalid data';
}
