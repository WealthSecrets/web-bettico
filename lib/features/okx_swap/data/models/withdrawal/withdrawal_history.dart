// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal_history.freezed.dart';
part 'withdrawal_history.g.dart';

@freezed
class WithdrawalHistory with _$WithdrawalHistory {
  const factory WithdrawalHistory({
    @JsonKey(name: 'subAcct') required String subAccount,
    @JsonKey(name: 'chain') required String chain,
    @JsonKey(name: 'fee') required String fee,
    @JsonKey(name: 'feeCcy') String? feeCurrency,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'clientId') String? clientID,
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'txId') required String transactionID,
    @JsonKey(name: 'to') required String toAddress,
    @JsonKey(name: 'areaCodeTo') String? areaCodeTo,
    @JsonKey(name: 'state') required String state,
    @JsonKey(name: 'ts') required String timestamp,
    @JsonKey(name: 'wdId') required String withdrawalID,
  }) = _WithdrawalHistory;

  const WithdrawalHistory._();

  factory WithdrawalHistory.fromJson(Map<String, dynamic> json) => _$WithdrawalHistoryFromJson(json);

  factory WithdrawalHistory.mock() => const WithdrawalHistory(
        amount: '0.1',
        currency: 'BTC',
        chain: 'BTC-Bitcoin',
        fee: '0.0005',
        toAddress: '17DKe3kkkkiiiiTvAKKi2vMPbm1Bz3CMKw',
        subAccount: 'brokerTest1',
        feeCurrency: 'ETH',
        clientID: '',
        transactionID: '0x35c******b360a174d',
        areaCodeTo: '',
        state: '2',
        timestamp: '1655251200000',
        withdrawalID: '15447421',
      );

  factory WithdrawalHistory.empty() => const WithdrawalHistory(
        amount: '',
        currency: '',
        chain: '',
        fee: '',
        toAddress: '',
        subAccount: '',
        feeCurrency: '',
        clientID: '',
        transactionID: '',
        areaCodeTo: '',
        state: '',
        timestamp: '',
        withdrawalID: '',
      );
}
