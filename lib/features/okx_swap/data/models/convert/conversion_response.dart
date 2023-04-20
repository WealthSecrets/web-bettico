// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversion_response.freezed.dart';
part 'conversion_response.g.dart';

enum ConversionState { fullyFilled, rejected }

@freezed
class ConversionResponse with _$ConversionResponse {
  const factory ConversionResponse({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'clTReqId') required String clientOrderId,
    @JsonKey(name: 'fillBaseSz') required String baseFilledAmount,
    @JsonKey(name: 'fillPx') required String rate,
    @JsonKey(name: 'fillQuoteSz') required String filledQuoteAmount,
    @JsonKey(name: 'instId') required String pair,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'quoteId') required String quoteId,
    @JsonKey(name: 'state') required ConversionState state,
    @JsonKey(name: 'side') required String side,
    @JsonKey(name: 'tradeId') required String tradeId,
    @JsonKey(name: 'ts') required String timestamp,
  }) = _ConversionResponse;

  const ConversionResponse._();

  factory ConversionResponse.fromJson(Map<String, dynamic> json) => _$ConversionResponseFromJson(json);

  factory ConversionResponse.mock() => const ConversionResponse(
        baseCurrency: 'ETH',
        clientOrderId: '',
        baseFilledAmount: '0.01023052',
        rate: '2932.40104429',
        filledQuoteAmount: '30',
        pair: 'ETH-USDT',
        quoteCurrency: 'USDT',
        quoteId: 'quoterETH-USDT16461885104612381',
        side: 'buy',
        state: ConversionState.fullyFilled,
        tradeId: 'trader16461885203381437',
        timestamp: '1646188520338',
      );

  factory ConversionResponse.empty() => const ConversionResponse(
        baseCurrency: '',
        clientOrderId: '',
        baseFilledAmount: '',
        rate: '',
        filledQuoteAmount: '',
        pair: '',
        quoteCurrency: '',
        quoteId: '',
        side: '',
        state: ConversionState.fullyFilled,
        tradeId: '',
        timestamp: '',
      );
}
