// ignore_for_file: invalid_annotation_target

import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_model.freezed.dart';
part 'reply_model.g.dart';

@freezed
class Reply with _$Reply {
  const factory Reply({
    @JsonKey(name: '_id') required String id,
    String? text,
    required String commentId,
    @JsonKey(name: 'userId') required User user,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Reply;

  const Reply._();

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  factory Reply.empty() => Reply(
        id: '',
        user: User.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        commentId: '',
        text: '',
      );
}
