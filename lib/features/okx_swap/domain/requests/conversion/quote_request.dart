// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_request.freezed.dart';
part 'quote_request.g.dart';

@freezed
class QuoteRequest with _$QuoteRequest {
  const factory QuoteRequest({
    @JsonKey(name: 'baseCcy') required String baseCurrency,
    @JsonKey(name: 'quoteCcy') required String quoteCurrency,
    @JsonKey(name: 'side') required String side,
    @JsonKey(name: 'rfqSz') required String realAmount,
    @JsonKey(name: 'rfqSzCcy') required String realAmountCurrency,
  }) = _QuoteRequest;
  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);
}
