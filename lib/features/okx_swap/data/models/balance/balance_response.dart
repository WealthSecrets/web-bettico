// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_response.freezed.dart';
part 'balance_response.g.dart';

@freezed
class BalanceResponse with _$BalanceResponse {
  const factory BalanceResponse({
    @JsonKey(name: 'totalEq') required String total,
    @JsonKey(name: 'balances') required List<Balance> balances,
  }) = _BalanceResponse;

  const BalanceResponse._();

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);

  factory BalanceResponse.mock() => BalanceResponse(
        total: '2.32',
        balances: <Balance>[Balance.mock()],
      );

  factory BalanceResponse.empty() => BalanceResponse(
        total: '',
        balances: <Balance>[Balance.empty()],
      );
}

@freezed
class Balance with _$Balance {
  const factory Balance({
    @JsonKey(name: 'availBal') required String availableBalance,
    @JsonKey(name: 'bal') required String balance,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'frozenBal') required String fronzenBalance,
    @JsonKey(name: 'usd') required String usd,
    @JsonKey(name: 'marketValue') required String marketValue,
  }) = _Balance;

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  factory Balance.mock() => const Balance(
      availableBalance: '2.33',
      balance: '2.36',
      currency: 'USDT',
      fronzenBalance: '0',
      usd: '2.35',
      marketValue: '1.000');

  factory Balance.empty() => const Balance(
      availableBalance: '',
      balance: '',
      currency: '',
      fronzenBalance: '',
      usd: '',
      marketValue: '');
}
