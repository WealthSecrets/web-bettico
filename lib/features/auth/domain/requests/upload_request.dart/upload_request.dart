import 'package:flutter/services.dart';

import '/features/auth/domain/requests/identification/identification_request.dart';

class UploadRequest {
  const UploadRequest({required this.file, required this.request, required this.onSendProgress});
  final Uint8List file;
  final IdentificationRequest request;
  final Function(int count, int total) onSendProgress;
}
