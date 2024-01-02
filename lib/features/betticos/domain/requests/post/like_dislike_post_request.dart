// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'like_dislike_post_request.freezed.dart';
part 'like_dislike_post_request.g.dart';

@freezed
class LikeDislikePostRequest with _$LikeDislikePostRequest {
  const factory LikeDislikePostRequest({required String user}) = _LikeDislikePostRequest;
  factory LikeDislikePostRequest.fromJson(Map<String, dynamic> json) => _$LikeDislikePostRequestFromJson(json);
}
