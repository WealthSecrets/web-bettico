// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_update_request.freezed.dart';
part 'transaction_update_request.g.dart';

@freezed
class TransactionUpdateRequest with _$TransactionUpdateRequest {
  const factory TransactionUpdateRequest({
    @JsonKey(name: 'bet') required String betId,
    String? hash,
  }) = _TransactionUpdateRequest;
  factory TransactionUpdateRequest.fromJson(Map<String, dynamic> json) => _$TransactionUpdateRequestFromJson(json);
}
