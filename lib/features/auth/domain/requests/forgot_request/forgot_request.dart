import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_request.freezed.dart';
part 'forgot_request.g.dart';

@freezed
class ForgotRequest with _$ForgotRequest {
  const factory ForgotRequest({
    required String email,
  }) = _ForgotRequest;
  factory ForgotRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotRequestFromJson(json);
}
