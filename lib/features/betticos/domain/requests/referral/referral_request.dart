import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral_request.freezed.dart';
part 'referral_request.g.dart';

@freezed
class ReferralRequest with _$ReferralRequest {
  const factory ReferralRequest({
    required String email,
  }) = _ReferralRequest;
  factory ReferralRequest.fromJson(Map<String, dynamic> json) =>
      _$ReferralRequestFromJson(json);
}
