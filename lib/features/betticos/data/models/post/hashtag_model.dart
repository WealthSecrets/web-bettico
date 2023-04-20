// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hashtag_model.freezed.dart';
part 'hashtag_model.g.dart';

@freezed
class Hashtag with _$Hashtag {
  const factory Hashtag({
    @JsonKey(name: '_id') required String name,
    required int count,
  }) = _Hashtag;

  const Hashtag._();

  factory Hashtag.fromJson(Map<String, dynamic> json) => _$HashtagFromJson(json);

  factory Hashtag.empty() => const Hashtag(name: '#newpost', count: 1);
}
