// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'resolve_user_request.freezed.dart';
part 'resolve_user_request.g.dart';

@freezed
class ResolveUserRequest with _$ResolveUserRequest {
  const factory ResolveUserRequest({
    required String userId,
  }) = _ResolveUserRequest;
  factory ResolveUserRequest.fromJson(Map<String, dynamic> json) => _$ResolveUserRequestFromJson(json);
}
