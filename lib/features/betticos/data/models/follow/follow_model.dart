// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_model.freezed.dart';
part 'follow_model.g.dart';

@freezed
class Follow with _$Follow {
  const factory Follow({
    @JsonKey(name: '_id') required String id,
    required String followerId,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Follow;

  const Follow._();

  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);

  factory Follow.empty() => Follow(
        id: '',
        userId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        followerId: '',
      );
}
