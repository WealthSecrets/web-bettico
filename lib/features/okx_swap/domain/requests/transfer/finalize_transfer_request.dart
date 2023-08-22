// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'finalize_transfer_request.freezed.dart';
part 'finalize_transfer_request.g.dart';

@freezed
class FinalizeTransferRequest with _$FinalizeTransferRequest {
  const factory FinalizeTransferRequest({
    @JsonKey(name: 'transfer_code') required String transferCode,
    @JsonKey(name: 'otp') required String otp,
  }) = _FinalizeTransferRequest;
  factory FinalizeTransferRequest.fromJson(Map<String, dynamic> json) => _$FinalizeTransferRequestFromJson(json);
}
