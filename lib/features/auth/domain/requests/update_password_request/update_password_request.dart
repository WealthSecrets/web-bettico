import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_request.freezed.dart';
part 'update_password_request.g.dart';

@freezed
class UpdatePasswordRequest with _$UpdatePasswordRequest {
  const factory UpdatePasswordRequest({
    required String password,
    required String confirmPassword,
    required String passwordCurrent,
  }) = _UpdatePasswordRequest;
  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) => _$UpdatePasswordRequestFromJson(json);
}
