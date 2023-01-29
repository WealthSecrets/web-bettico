// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_pair.freezed.dart';
part 'currency_pair.g.dart';

@freezed
class CurrencyPair with _$CurrencyPair {
  const factory CurrencyPair({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'baseCcyMax') required String baseCurrencyMaximumAmount,
    @JsonKey(name: 'baseCcyMin') required String baseCurrencyMinimumAmount,
    @JsonKey(name: 'instId') required String pair,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'quoteCcyMax') required String quoteCurrencyMaximumAmount,
    @JsonKey(name: 'quoteCcyMin') required String quoteCurrencyMinimumAmount,
  }) = _CurrencyPair;

  const CurrencyPair._();

  factory CurrencyPair.fromJson(Map<String, dynamic> json) =>
      _$CurrencyPairFromJson(json);

  factory CurrencyPair.mock() => const CurrencyPair(
        baseCurrency: 'BTC',
        baseCurrencyMaximumAmount: '0.5',
        baseCurrencyMinimumAmount: '0.0001',
        pair: 'BTC-USDT',
        quoteCurrency: 'USDT',
        quoteCurrencyMaximumAmount: '10000',
        quoteCurrencyMinimumAmount: '1',
      );

  factory CurrencyPair.empty() => const CurrencyPair(
        baseCurrency: '',
        baseCurrencyMaximumAmount: '',
        baseCurrencyMinimumAmount: '',
        pair: '',
        quoteCurrency: '',
        quoteCurrencyMaximumAmount: '',
        quoteCurrencyMinimumAmount: '',
      );
}
