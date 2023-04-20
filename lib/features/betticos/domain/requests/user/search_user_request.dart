// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_request.freezed.dart';
part 'search_user_request.g.dart';

@freezed
class SearchUserRequest with _$SearchUserRequest {
  const factory SearchUserRequest({
    required String query,
  }) = _SearchUserRequest;
  factory SearchUserRequest.fromJson(Map<String, dynamic> json) => _$SearchUserRequestFromJson(json);
}
