import 'package:flutter/services.dart';

class UpdatePhotoRequest {
  const UpdatePhotoRequest({
    required this.file,
    required this.onSendProgress,
  });
  final Uint8List file;
  final Function(int count, int total) onSendProgress;
}
