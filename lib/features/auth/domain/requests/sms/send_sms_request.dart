import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_sms_request.freezed.dart';
part 'send_sms_request.g.dart';

@freezed
class SendSmsRequest with _$SendSmsRequest {
  const factory SendSmsRequest({
    required String phone,
  }) = _SendSmsRequest;
  factory SendSmsRequest.fromJson(Map<String, dynamic> json) => _$SendSmsRequestFromJson(json);
}
