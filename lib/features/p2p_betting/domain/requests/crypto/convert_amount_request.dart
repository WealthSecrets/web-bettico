// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'convert_amount_request.freezed.dart';
part 'convert_amount_request.g.dart';

@freezed
class ConvertAmountRequest with _$ConvertAmountRequest {
  const factory ConvertAmountRequest({
    required double amount,
    required String currency,
  }) = _ConvertAmountRequest;
  factory ConvertAmountRequest.fromJson(Map<String, dynamic> json) => _$ConvertAmountRequestFromJson(json);
}
