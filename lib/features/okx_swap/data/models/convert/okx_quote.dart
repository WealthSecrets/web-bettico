// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'okx_quote.freezed.dart';
part 'okx_quote.g.dart';

@freezed
class OkxQuote with _$OkxQuote {
  const factory OkxQuote({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'baseSz') required String baseConvertedAmount,
    @JsonKey(name: 'clQReqId') required String clientOrderId,
    @JsonKey(name: 'cnvtPx') required String rate,
    @JsonKey(name: 'origRfqSz') String? originalRFQAmount,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'quoteId') required String quoteId,
    @JsonKey(name: 'quoteSz') required String quoteConvertedAmount,
    @JsonKey(name: 'quoteTime') required String timestamp,
    @JsonKey(name: 'rfqSz') required String realRFQAmount,
    @JsonKey(name: 'rfqSzCcy') required String rfqCurrency,
    @JsonKey(name: 'side') required String side,
    @JsonKey(name: 'ttlMs') required String expiryTime,
  }) = _OkxQuote;

  const OkxQuote._();

  factory OkxQuote.fromJson(Map<String, dynamic> json) => _$OkxQuoteFromJson(json);

  factory OkxQuote.mock() => const OkxQuote(
        baseCurrency: 'ETH',
        baseConvertedAmount: '0.01023052',
        clientOrderId: '',
        rate: '2932.40104429',
        originalRFQAmount: '30',
        quoteCurrency: 'USDT',
        quoteId: 'quoterETH-USDT16461885104612381',
        quoteConvertedAmount: '30',
        timestamp: '1646188510461',
        realRFQAmount: '30',
        rfqCurrency: 'USDT',
        side: 'buy',
        expiryTime: '10000',
      );

  factory OkxQuote.empty() => const OkxQuote(
        baseCurrency: '',
        baseConvertedAmount: '',
        clientOrderId: '',
        rate: '',
        originalRFQAmount: '',
        quoteCurrency: '',
        quoteId: '',
        quoteConvertedAmount: '',
        timestamp: '',
        realRFQAmount: '',
        rfqCurrency: '',
        side: '',
        expiryTime: '',
      );
}
