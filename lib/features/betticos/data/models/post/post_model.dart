// ignore_for_file: invalid_annotation_target

import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: '_id') required String id,
    String? text,
    List<String>? images,
    required int comments,
    String? slipCode,
    required bool isOddbox,
    required List<String> shares,
    required List<String> likeUsers,
    required List<String> dislikeUsers,
    required User user,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Post;

  const Post._();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.empty() => Post(
        id: '',
        user: User.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        comments: 0,
        isOddbox: false,
        likeUsers: <String>[],
        dislikeUsers: <String>[],
        shares: <String>[],
      );
}
