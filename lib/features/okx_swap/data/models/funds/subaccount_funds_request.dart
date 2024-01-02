// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'subaccount_funds_request.freezed.dart';
part 'subaccount_funds_request.g.dart';

@freezed
class SubAccountFundsRequest with _$SubAccountFundsRequest {
  const factory SubAccountFundsRequest({
    @JsonKey(name: 'amount') required String amount,
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'to') required String to,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'subAccount') required String subAccount,
  }) = _SubAccountFundsRequest;

  const SubAccountFundsRequest._();

  factory SubAccountFundsRequest.fromJson(Map<String, dynamic> json) => _$SubAccountFundsRequestFromJson(json);

  factory SubAccountFundsRequest.mock() => const SubAccountFundsRequest(
        amount: '0.1',
        currency: 'BTC',
        from: '6',
        to: '6',
        subAccount: 'okxuser1',
      );

  factory SubAccountFundsRequest.empty() => const SubAccountFundsRequest(
        amount: '',
        currency: '',
        from: '',
        to: '',
        subAccount: '',
      );
}
