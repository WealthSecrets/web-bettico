// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'repost_request.freezed.dart';
part 'repost_request.g.dart';

@freezed
class RepostRequest with _$RepostRequest {
  const factory RepostRequest({
    required String postId,
    String? commentsOnRepost,
  }) = _RepostRequest;
  factory RepostRequest.fromJson(Map<String, dynamic> json) => _$RepostRequestFromJson(json);
}
