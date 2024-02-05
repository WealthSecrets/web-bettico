// ignore_for_file: invalid_annotation_target
import 'package:betticos/common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'repost_model.freezed.dart';
part 'repost_model.g.dart';

@freezed
class Repost with _$Repost {
  const factory Repost({
    @JsonKey(name: '_id') required String id,
    User? user,
    @JsonKey(name: 'commentsOnRepost') required String comment,
  }) = _Repost;

  const Repost._();

  factory Repost.fromJson(Map<String, dynamic> json) => _$RepostFromJson(json);
}
