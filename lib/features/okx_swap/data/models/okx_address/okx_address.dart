// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'okx_address.freezed.dart';
part 'okx_address.g.dart';

@freezed
class OkxAddress with _$OkxAddress {
  const factory OkxAddress({
    @JsonKey(name: 'chain') String? chain,
    @JsonKey(name: 'ccy') required String currency,
    @JsonKey(name: 'addr') required String address,
    @JsonKey(name: 'ts') String? timeStamp,
  }) = _OkxAddress;

  const OkxAddress._();

  factory OkxAddress.fromJson(Map<String, dynamic> json) => _$OkxAddressFromJson(json);

  factory OkxAddress.mock() => const OkxAddress(currency: 'BTC', address: '0xff028909d090f0ww');

  factory OkxAddress.empty() => const OkxAddress(currency: '', address: '');
}
