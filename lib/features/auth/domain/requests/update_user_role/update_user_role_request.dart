import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_role_request.freezed.dart';
part 'update_user_role_request.g.dart';

@freezed
class UpdateUserRoleRequest with _$UpdateUserRoleRequest {
  const factory UpdateUserRoleRequest({required String role}) = _UpdateUserRoleRequest;
  factory UpdateUserRoleRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRoleRequestFromJson(json);
}
