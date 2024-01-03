import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_sms_request.freezed.dart';
part 'verify_sms_request.g.dart';

@freezed
class VerifySmsRequest with _$VerifySmsRequest {
  const factory VerifySmsRequest({required String phone, required String code}) = _VerifySmsRequest;
  factory VerifySmsRequest.fromJson(Map<String, dynamic> json) => _$VerifySmsRequestFromJson(json);
}
