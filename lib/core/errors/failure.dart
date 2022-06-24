import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.server(
      {@Default('Something went wrong.') String message}) = ServerError;
  const factory Failure.client(
      {@Default('Something went wrong.') String message}) = ClientError;
  const factory Failure.timeout(
      {@Default('The request timed out.') String message}) = TimeOutError;
  const factory Failure.generic(
      {@Default('Something went wrong.') String message}) = GenericError;
}
