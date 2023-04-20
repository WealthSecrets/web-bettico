// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_posts_or_oddboxes_request.freezed.dart';
part 'my_posts_or_oddboxes_request.g.dart';

@freezed
class MyPostsOrOddboxesRequest with _$MyPostsOrOddboxesRequest {
  const factory MyPostsOrOddboxesRequest({
    required String userId,
  }) = _MyPostsOrOddboxesRequest;
  factory MyPostsOrOddboxesRequest.fromJson(Map<String, dynamic> json) => _$MyPostsOrOddboxesRequestFromJson(json);
}
