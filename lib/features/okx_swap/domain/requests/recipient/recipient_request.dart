// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipient_request.freezed.dart';
part 'recipient_request.g.dart';

@freezed
class RecipientRequest with _$RecipientRequest {
  const factory RecipientRequest({
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'account_number') required String accountNumber,
    @JsonKey(name: 'bank_code') required String bankCode,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'usd') required double usdAmount,
    @JsonKey(name: 'amount') required double amount,
    @JsonKey(name: 'destination') required String destination,
  }) = _RecipientRequest;
  factory RecipientRequest.fromJson(Map<String, dynamic> json) => _$RecipientRequestFromJson(json);
}
