import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_user_request.freezed.dart';
part 'verify_user_request.g.dart';

@freezed
class VerifyUserRequest with _$VerifyUserRequest {
  const factory VerifyUserRequest({required String token, required String email, String? photo, String? username}) =
      _VerifyUserRequest;
  factory VerifyUserRequest.fromJson(Map<String, dynamic> json) => _$VerifyUserRequestFromJson(json);
}
