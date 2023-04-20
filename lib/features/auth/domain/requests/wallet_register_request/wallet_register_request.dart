// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_register_request.freezed.dart';
part 'wallet_register_request.g.dart';

@freezed
class WalletRegisterRequest with _$WalletRegisterRequest {
  const factory WalletRegisterRequest({
    required String wallet,
    String? password,
    String? confirmPassword,
    String? role,
    String? referralCode,
    String? type,
  }) = _WalletRegisterRequest;
  factory WalletRegisterRequest.fromJson(Map<String, dynamic> json) => _$WalletRegisterRequestFromJson(json);
}
