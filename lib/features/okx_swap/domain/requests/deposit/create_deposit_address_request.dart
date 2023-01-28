// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_deposit_address_request.freezed.dart';
part 'create_deposit_address_request.g.dart';

@freezed
class CreateDepositAddressRequest with _$CreateDepositAddressRequest {
  const factory CreateDepositAddressRequest({
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'chain') String? chain,
  }) = _CreateDepositAddressRequest;
  factory CreateDepositAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDepositAddressRequestFromJson(json);
}
