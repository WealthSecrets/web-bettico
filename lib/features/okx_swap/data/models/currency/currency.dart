// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    @JsonKey(name: 'chain') String? chain,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'logoLink') String? logoLink,
    @JsonKey(name: 'minFee') String? minFee,
    @JsonKey(name: 'maxFee') String? maxFee,
  }) = _Currency;

  const Currency._();

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  factory Currency.mock() => const Currency(
        currency: 'BTC',
        name: 'Bitcoin',
        logoLink:
            'https://static.coinall.ltd/cdn/assets/imgs/221/5F74EB20302D7761.png',
      );

  factory Currency.empty() => const Currency(currency: '', logoLink: '');
}
