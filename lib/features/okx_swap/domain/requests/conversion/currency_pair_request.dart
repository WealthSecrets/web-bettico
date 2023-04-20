// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_pair_request.freezed.dart';
part 'currency_pair_request.g.dart';

@freezed
class CurrencyPairRequest with _$CurrencyPairRequest {
  const factory CurrencyPairRequest({
    @JsonKey(name: 'fromCcy') required String fromCurrency,
    @JsonKey(name: 'toCcy') required String toCurrency,
  }) = _CurrencyPairRequest;
  factory CurrencyPairRequest.fromJson(Map<String, dynamic> json) => _$CurrencyPairRequestFromJson(json);
}
