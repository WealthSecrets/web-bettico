// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repost_response.freezed.dart';
part 'repost_response.g.dart';

@freezed
class RepostResponse with _$RepostResponse {
  const factory RepostResponse({
    @JsonKey(name: 'commentsOnRepost') required String comment,
    @JsonKey(name: 'post') required Post post,
  }) = _RepostResponse;
  factory RepostResponse.fromJson(Map<String, dynamic> json) => _$RepostResponseFromJson(json);
}
