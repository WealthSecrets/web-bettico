// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'subaccount_funds_response.freezed.dart';
part 'subaccount_funds_response.g.dart';

@freezed
class SubAccountFundsResponse with _$SubAccountFundsResponse {
  const factory SubAccountFundsResponse({
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'to') required String to,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'transId') required String transactionID,
    @JsonKey(name: 'clientId') String? clientID,
  }) = _SubAccountFundsResponse;

  const SubAccountFundsResponse._();

  factory SubAccountFundsResponse.fromJson(Map<String, dynamic> json) => _$SubAccountFundsResponseFromJson(json);

  factory SubAccountFundsResponse.mock() => const SubAccountFundsResponse(
        amount: '0.1',
        currency: 'BTC',
        from: '6',
        to: '6',
        transactionID: '19633018',
      );

  factory SubAccountFundsResponse.empty() => const SubAccountFundsResponse(
        amount: '',
        currency: '',
        from: '',
        to: '',
        transactionID: '',
      );
}
