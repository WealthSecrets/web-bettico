// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_response.freezed.dart';
part 'balance_response.g.dart';

@freezed
class BalanceResponse with _$BalanceResponse {
  const factory BalanceResponse({
    @JsonKey(name: 'availBal') required String availableBalance,
    @JsonKey(name: 'bal') required String balance,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'frozenBal') required String fronzenBalance,
  }) = _BalanceResponse;

  const BalanceResponse._();

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);

  factory BalanceResponse.mock() => const BalanceResponse(
        availableBalance: '2.3235798176000004',
        balance: '2.3235798176000004',
        currency: 'USDT',
        fronzenBalance: '0',
      );

  factory BalanceResponse.empty() => const BalanceResponse(
        availableBalance: '',
        balance: '',
        currency: '',
        fronzenBalance: '',
      );
}
