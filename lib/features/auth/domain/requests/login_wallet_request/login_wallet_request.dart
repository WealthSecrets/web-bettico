import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_wallet_request.freezed.dart';
part 'login_wallet_request.g.dart';

@freezed
class LoginWalletRequest with _$LoginWalletRequest {
  const factory LoginWalletRequest({
    required String wallet,
  }) = _LoginWalletRequest;
  factory LoginWalletRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginWalletRequestFromJson(json);
}
