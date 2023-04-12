// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'quote_usd_model.dart';

part 'coin_quote_model.freezed.dart';
part 'coin_quote_model.g.dart';

@freezed
class CoinQuote with _$CoinQuote {
  const factory CoinQuote({
    @JsonKey(name: 'USD') required QuoteUsd usd,
  }) = _CoinQuote;

  const CoinQuote._();

  factory CoinQuote.fromJson(Map<String, dynamic> json) =>
      _$CoinQuoteFromJson(json);

  factory CoinQuote.mock() => CoinQuote(
        usd: QuoteUsd.mock(),
      );

  factory CoinQuote.empty() => CoinQuote(
        usd: QuoteUsd.empty(),
      );
}
