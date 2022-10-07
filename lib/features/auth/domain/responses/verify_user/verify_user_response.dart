import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_user_response.freezed.dart';
part 'verify_user_response.g.dart';

@freezed
class VerifyUserResponse with _$VerifyUserResponse {
  const factory VerifyUserResponse({
    required String email,
    required bool verified,
  }) = _VerifyUserResponse;
  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) => _$VerifyUserResponseFromJson(json);
}
