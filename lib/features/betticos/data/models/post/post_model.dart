// ignore_for_file: invalid_annotation_target
import 'package:betticos/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: '_id') required String id,
    String? text,
    List<String>? images,
    int? comments,
    String? slipCode,
    bool? boosted,
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

  factory Post.mock() => Post(
        id: '625e06f392dad8843a4d30c6',
        user: User.mock(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        comments: 3,
        isOddbox: false,
        text: 'Hello world, this is a test post',
        images: <String>[],
        likeUsers: <String>[
          '625e06f392dad8843a4d3e0f',
          '625e06f892dad8843a4d3e0f',
          '625e06f392d092033a4d3e0f',
          '625e06f392dwe8843a4d3e0f',
          '625e06f892dad8843a4d3e0f',
          '625e098289d092033a4d3e0f',
        ],
        dislikeUsers: <String>[],
        shares: <String>[],
      );
}
