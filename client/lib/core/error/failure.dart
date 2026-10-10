import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Ошибка, понятная остальному приложению. Слой data переводит в неё исключения сети и парсинга.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.noConnection() = NoConnectionFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.server(int statusCode) = ServerFailure;

  /// Сервер отклонил данные (422).
  const factory Failure.rejected(String message) = RejectedFailure;
  const factory Failure.malformedResponse() = MalformedResponseFailure;
}
