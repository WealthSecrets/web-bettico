import 'dart:io';
import '/features/auth/domain/requests/identification/identification_request.dart';

class UploadRequest {
  const UploadRequest({
    required this.file,
    required this.request,
    required this.onSendProgress,
  });
  final File file;
  final IdentificationRequest request;
  final Function(int count, int total) onSendProgress;
}
