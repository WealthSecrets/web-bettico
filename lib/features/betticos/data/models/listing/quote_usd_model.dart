// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_usd_model.freezed.dart';
part 'quote_usd_model.g.dart';

@freezed
class QuoteUsd with _$QuoteUsd {
  const factory QuoteUsd({
    required double price,
    @JsonKey(name: 'volume_24h') required double volume24h,
    @JsonKey(name: 'volume_change_24h') required double volumeChange24h,
    @JsonKey(name: 'percent_change_1h') required double percentChange1h,
    @JsonKey(name: 'percent_change_24h') required double percentChange24h,
    @JsonKey(name: 'percent_change_7d') required double percentChange7d,
    @JsonKey(name: 'market_cap') required double marketCap,
    @JsonKey(name: 'market_cap_dominance') required double marketCapDominance,
    @JsonKey(name: 'fully_diluted_market_cap') double? fullyDilutedMarketCap,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  }) = _QuoteUsd;

  const QuoteUsd._();

  factory QuoteUsd.fromJson(Map<String, dynamic> json) => _$QuoteUsdFromJson(json);

  factory QuoteUsd.mock() => QuoteUsd(
        price: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        volume24h: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        volumeChange24h: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        percentChange1h: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        percentChange24h: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        percentChange7d: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        marketCap: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
        marketCapDominance: Faker().randomGenerator.decimal(scale: 999999999, min: 100000000),
      );

  factory QuoteUsd.empty() => const QuoteUsd(
        price: 0.0,
        volume24h: 0.0,
        volumeChange24h: 0.0,
        percentChange1h: 0.0,
        percentChange24h: 0.0,
        percentChange7d: 0.0,
        marketCap: 0.0,
        marketCapDominance: 0.0,
      );
}
