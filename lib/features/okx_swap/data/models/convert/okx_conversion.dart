// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'okx_conversion.freezed.dart';
part 'okx_conversion.g.dart';

@freezed
class OkxConversion with _$OkxConversion {
  const factory OkxConversion({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'fillBaseSz') required String baseFilledAmount,
    @JsonKey(name: 'fillPx') required String rate,
    @JsonKey(name: 'fillQuoteSz') required String filledQuoteAmount,
    @JsonKey(name: 'instId') required String pair,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'state') required ConversionState state,
    @JsonKey(name: 'side') required String side,
    @JsonKey(name: 'tradeId') required String tradeId,
    @JsonKey(name: 'ts') required String timestamp,
  }) = _OkxConversion;

  const OkxConversion._();

  factory OkxConversion.fromJson(Map<String, dynamic> json) => _$OkxConversionFromJson(json);

  factory OkxConversion.mock() => const OkxConversion(
        baseCurrency: 'ETH',
        baseFilledAmount: '0.01023052',
        rate: '2932.40104429',
        filledQuoteAmount: '30',
        pair: 'ETH-USDT',
        quoteCurrency: 'USDT',
        side: 'buy',
        state: ConversionState.fullyFilled,
        tradeId: 'trader16461885203381437',
        timestamp: '1646188520338',
      );

  factory OkxConversion.empty() => const OkxConversion(
        baseCurrency: '',
        baseFilledAmount: '',
        rate: '',
        filledQuoteAmount: '',
        pair: '',
        quoteCurrency: '',
        side: '',
        state: ConversionState.fullyFilled,
        tradeId: '',
        timestamp: '',
      );
}
