// ignore_for_file: invalid_annotation_target
import 'package:betticos/common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../post/post_model.dart';
part 'repost_model.freezed.dart';
part 'repost_model.g.dart';

@freezed
class Repost with _$Repost {
  const factory Repost({
    @JsonKey(name: '_id') required String id,
    String? text,
    List<String>? images,
    int? comments,
    String? slipCode,
    bool? boosted,
    required List<String> shares,
    required List<String> likeUsers,
    required List<String> dislikeUsers,
    required List<String> bookmarks,
    required User user,
    required Post post,
    required String commentsOnRepost,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Repost;

  const Repost._();

  factory Repost.fromJson(Map<String, dynamic> json) => _$RepostFromJson(json);

  factory Repost.empty() => Repost(
        id: '',
        user: User.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        comments: 0,
        likeUsers: <String>[],
        dislikeUsers: <String>[],
        bookmarks: <String>[],
        shares: <String>[],
        commentsOnRepost: '',
        post: Post.empty(),
      );

  factory Repost.mock() => Repost(
        id: '625e06f392dad8843a4d30c6',
        user: User.mock(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        comments: 3,
        text: 'Hello world, this is a test Repost',
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
        bookmarks: <String>[],
        shares: <String>[],
        commentsOnRepost: 'this is a repost',
        post: Post.mock(),
      );
}
