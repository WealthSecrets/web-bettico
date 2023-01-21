// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_subaccount_request.freezed.dart';
part 'create_subaccount_request.g.dart';

@freezed
class CreateSubAccountRequest with _$CreateSubAccountRequest {
  const factory CreateSubAccountRequest({
    @JsonKey(name: 'subAcct') required String subAccount,
    @JsonKey(name: 'passphrase') required String passPhrase,
    String? label,
  }) = _TransactionRequest;
  factory CreateSubAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSubAccountRequestFromJson(json);
}
