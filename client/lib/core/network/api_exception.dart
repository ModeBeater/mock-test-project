/// Исключения слоя data. Наружу из репозиториев не выходят — превращаются в Failure.
sealed class ApiException implements Exception {
  const ApiException();
}

final class NoConnectionException extends ApiException {
  const NoConnectionException();
}

final class RequestTimeoutException extends ApiException {
  const RequestTimeoutException();
}

final class MalformedResponseException extends ApiException {
  const MalformedResponseException();
}

final class UnexpectedStatusException extends ApiException {
  const UnexpectedStatusException(this.statusCode, this.body);

  final int statusCode;
  final Object? body;
}
