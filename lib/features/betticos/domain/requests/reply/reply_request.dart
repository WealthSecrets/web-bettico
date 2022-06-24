// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_request.freezed.dart';
part 'reply_request.g.dart';

@freezed
class ReplyRequest with _$ReplyRequest {
  const factory ReplyRequest({
    required String text,
    required String commentId,
  }) = _ReplyRequest;
  factory ReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$ReplyRequestFromJson(json);
}
