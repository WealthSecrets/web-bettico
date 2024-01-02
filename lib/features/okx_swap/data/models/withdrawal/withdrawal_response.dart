// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'withdrawal_response.freezed.dart';
part 'withdrawal_response.g.dart';

@freezed
class WithdrawalResponse with _$WithdrawalResponse {
  const factory WithdrawalResponse({
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'wdId') required String withdrawalId,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'clientId') String? clientID,
    @JsonKey(name: 'chain') required String chain,
  }) = _WithdrawalResponse;

  const WithdrawalResponse._();

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) => _$WithdrawalResponseFromJson(json);

  factory WithdrawalResponse.mock() => const WithdrawalResponse(
        amount: '0.1',
        withdrawalId: '67485',
        currency: 'BTC',
        clientID: '',
        chain: 'BTC-Bitcoin',
      );

  factory WithdrawalResponse.empty() => const WithdrawalResponse(
        amount: '',
        withdrawalId: '',
        currency: '',
        clientID: '',
        chain: '',
      );
}
