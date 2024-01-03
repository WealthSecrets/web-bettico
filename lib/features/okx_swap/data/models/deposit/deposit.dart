// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'deposit.freezed.dart';
part 'deposit.g.dart';

@freezed
class Deposit with _$Deposit {
  const factory Deposit({
    @JsonKey(name: 'depId') required String id,
    @JsonKey(name: 'subAcct') required String subAccount,
    @JsonKey(name: 'amt') required String amount,
    @JsonKey(name: 'txId') required String transactionId,
    @JsonKey(name: 'to') String? to,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'chain') required String chain,
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'state') required DepositState state,
    @JsonKey(name: 'areaCodeFrom') String? areaCodeFrom,
    @JsonKey(name: 'actualDepBlkConfirm') String? actualDepositBlockConfirm,
    @JsonKey(name: 'ts') required String timestamp,
  }) = _Deposit;

  const Deposit._();

  factory Deposit.fromJson(Map<String, dynamic> json) => _$DepositFromJson(json);

  factory Deposit.mock() => Deposit(
        amount: '0.01044408',
        actualDepositBlockConfirm: '20',
        transactionId: '1915737_3_0_0_asset',
        currency: 'BTC',
        chain: 'BTC-Bitcoin',
        from: '13801825426',
        areaCodeFrom: '86',
        to: '',
        state: DepositState.values.first,
        timestamp: '1597026383085',
        subAccount: 'brokerTest1',
        id: '4703879',
      );

  factory Deposit.empty() => Deposit(
        amount: '',
        actualDepositBlockConfirm: '',
        transactionId: '',
        currency: '',
        chain: '',
        from: '',
        areaCodeFrom: '',
        to: '',
        state: DepositState.values.last,
        timestamp: '',
        subAccount: '',
        id: '',
      );
}

enum DepositState with DisplayNameEnumerable {
  @JsonValue(_zero)
  zero(_zero),
  @JsonValue(_one)
  one(_one),
  @JsonValue(_two)
  two(_two),
  @JsonValue(_eight)
  eight(_eight),
  @JsonValue(_eleven)
  eleven(_eleven),
  @JsonValue(_twelve)
  twelve(_twelve),
  @JsonValue(_thirty)
  thirty(_thirty);

  const DepositState(this.displayName);

  @override
  final String displayName;

  static const String _zero = '0';
  static const String _one = '1';
  static const String _two = '2';
  static const String _eight = '8';
  static const String _eleven = '11';
  static const String _twelve = '12';
  static const String _thirty = '13';

  static DepositState fromDisplayName(String displayName) {
    for (final DepositState item in DepositState.values) {
      if (item.displayName == displayName) {
        return item;
      }
    }
    throw ArgumentError('Deposit state of "$displayName" is not supported');
  }

  @override
  String toString() => displayName;
}

mixin DisplayNameEnumerable {
  String get displayName;
}
