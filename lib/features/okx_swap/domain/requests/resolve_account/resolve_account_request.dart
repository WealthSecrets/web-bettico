// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolve_account_request.freezed.dart';
part 'resolve_account_request.g.dart';

@freezed
class ResolveAccountRequest with _$ResolveAccountRequest {
  const factory ResolveAccountRequest({
    @JsonKey(name: 'account_number') required String accoutNumber,
    @JsonKey(name: 'bank_code') required String bankCode,
  }) = _ResolveAccountRequest;
  factory ResolveAccountRequest.fromJson(Map<String, dynamic> json) => _$ResolveAccountRequestFromJson(json);
}
