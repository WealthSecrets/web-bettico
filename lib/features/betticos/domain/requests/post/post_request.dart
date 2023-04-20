// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request.freezed.dart';
part 'post_request.g.dart';

@freezed
class PostRequest with _$PostRequest {
  const factory PostRequest({
    String? text,
    String? slipCode,
    bool? isOddbox,
    bool? isReply,
    String? postId,
    List<String>? likeUsers,
    List<String>? dislikeUsers,
    List<String>? shares,
    List<List<int>>? files,
  }) = _PostRequest;
  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostRequestFromJson(json);
}
