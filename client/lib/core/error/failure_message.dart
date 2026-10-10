import 'failure.dart';

extension FailureMessage on Failure {
  String get message => switch (this) {
        NoConnectionFailure() => 'Нет связи с сервером',
        TimeoutFailure() => 'Сервер не ответил вовремя',
        ServerFailure(:final statusCode) => 'Ошибка сервера ($statusCode)',
        RejectedFailure(:final message) => 'Сервер отклонил данные: $message',
        MalformedResponseFailure() => 'Сервер вернул некорректный ответ',
      };
}
