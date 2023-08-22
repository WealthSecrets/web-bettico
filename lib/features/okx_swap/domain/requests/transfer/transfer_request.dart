// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_request.freezed.dart';
part 'transfer_request.g.dart';

@freezed
class TransferRequest with _$TransferRequest {
  const factory TransferRequest({
    @JsonKey(name: 'source') required String source,
    @JsonKey(name: 'account_number') required String accountNumber,
    @JsonKey(name: 'amount') required double amount,
    @JsonKey(name: 'recipient') required String recipientCode,
  }) = _TransferRequest;
  factory TransferRequest.fromJson(Map<String, dynamic> json) => _$TransferRequestFromJson(json);
}
