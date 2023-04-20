// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_history.freezed.dart';
part 'transfer_history.g.dart';

@freezed
class TransferHistory with _$TransferHistory {
  const factory TransferHistory({
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'billId') required String billID,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'subAcct') required String subAccount,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'ts') required String timestamp,
  }) = _TransferHistory;

  const TransferHistory._();

  factory TransferHistory.fromJson(Map<String, dynamic> json) => _$TransferHistoryFromJson(json);

  factory TransferHistory.mock() => const TransferHistory(
        amount: '1',
        billID: '29180972',
        currency: 'USDT',
        subAccount: 'okxuser1',
        timestamp: '1679533100000',
        type: '1',
      );

  factory TransferHistory.empty() => const TransferHistory(
        amount: '',
        billID: '',
        currency: '',
        subAccount: '',
        timestamp: '',
        type: '',
      );
}
