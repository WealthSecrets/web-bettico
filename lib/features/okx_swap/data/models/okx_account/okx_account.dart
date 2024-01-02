// ignore_for_file: invalid_annotation_target
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'okx_account.freezed.dart';
part 'okx_account.g.dart';

@freezed
class OkxAccount with _$OkxAccount {
  const factory OkxAccount({
    @JsonKey(name: 'acctLv') String? accountLevel,
    @JsonKey(name: 'user') required User user,
    @JsonKey(name: 'ip') String? ipAddress,
    String? secretkey,
    String? apiKey,
    @JsonKey(name: 'label') String? label,
    @JsonKey(name: 'addresses') List<OkxAddress>? addresses,
    @JsonKey(name: '') List<OkxApi>? apiKeys,
    @JsonKey(name: 'subAcct') required String subAccount,
    @JsonKey(name: 'uid') String? uniqueID,
    @JsonKey(name: 'ts') String? timeStamp,
  }) = _OkxAccount;

  const OkxAccount._();

  factory OkxAccount.fromJson(Map<String, dynamic> json) => _$OkxAccountFromJson(json);

  factory OkxAccount.mock() =>
      OkxAccount(accountLevel: '1', subAccount: 'brokerTest5', user: User.mock(), addresses: <OkxAddress>[]);

  factory OkxAccount.empty() =>
      OkxAccount(accountLevel: '', subAccount: '', user: User.empty(), addresses: <OkxAddress>[]);
}
