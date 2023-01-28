// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_deposit_address_response.freezed.dart';
part 'create_deposit_address_response.g.dart';

@freezed
class CreateDepositAddressResponse with _$CreateDepositAddressResponse {
  const factory CreateDepositAddressResponse({
    @JsonKey(name: 'account') required OkxAccount account,
    @JsonKey(name: 'address') required OkxAddress address,
  }) = _CreateDepositAddressResponse;
  factory CreateDepositAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateDepositAddressResponseFromJson(json);
}
