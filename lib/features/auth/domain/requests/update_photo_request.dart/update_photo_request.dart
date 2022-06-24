import 'dart:io';

class UpdatePhotoRequest {
  const UpdatePhotoRequest({
    required this.file,
    required this.onSendProgress,
  });
  final File file;
  final Function(int count, int total) onSendProgress;
}
