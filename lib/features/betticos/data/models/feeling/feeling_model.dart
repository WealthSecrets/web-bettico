// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feeling_model.freezed.dart';
part 'feeling_model.g.dart';

@freezed
class Feeling with _$Feeling {
  const factory Feeling({
    @JsonKey(name: '_id') required String id,
    required String type,
    required String postId,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Feeling;

  const Feeling._();

  factory Feeling.fromJson(Map<String, dynamic> json) => _$FeelingFromJson(json);

  factory Feeling.empty() => Feeling(
        id: '',
        userId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        postId: '',
        type: '',
      );
}
