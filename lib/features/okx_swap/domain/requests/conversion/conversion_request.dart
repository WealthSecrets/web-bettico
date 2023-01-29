// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversion_request.freezed.dart';
part 'conversion_request.g.dart';

@freezed
class ConversionRequest with _$ConversionRequest {
  const factory ConversionRequest({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'side') required String side,
    @JsonKey(name: 'sz') required String realAmount,
    @JsonKey(name: 'szCcy') required String realAmountCurrency,
    @JsonKey(name: 'quoteId') required String quoteId,
    @JsonKey(name: 'clTReqId') required String clientOrderId,
  }) = _ConversionRequest;
  factory ConversionRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversionRequestFromJson(json);
}
