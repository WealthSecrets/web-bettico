import 'package:flutter/services.dart';

class AddPostRequest {
  AddPostRequest({
    required this.files,
    this.text,
    required this.onSendProgress,
    this.slipCode,
    this.isOddbox,
    this.postId,
    this.isReply = false,
  });
  final List<Uint8List> files;
  final bool? isOddbox;
  final String? slipCode;
  final String? text;
  final String? postId;
  final bool? isReply;
  final Function(int count, int total) onSendProgress;
}
