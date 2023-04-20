// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_device_request.freezed.dart';
part 'user_device_request.g.dart';

@freezed
class UserDeviceRequest with _$UserDeviceRequest {
  const factory UserDeviceRequest({
    required String device,
  }) = _UserDeviceRequest;
  factory UserDeviceRequest.fromJson(Map<String, dynamic> json) => _$UserDeviceRequestFromJson(json);
}
