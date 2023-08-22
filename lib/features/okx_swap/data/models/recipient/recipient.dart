// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipient.freezed.dart';
part 'recipient.g.dart';

@freezed
class Recipient with _$Recipient {
  const factory Recipient({
    @JsonKey(name: 'active') required bool active,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'domain') String? domain,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'integration') required int integration,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'recipient_code') required String recipientCode,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'details') required Details details,
  }) = _Recipient;

  const Recipient._();

  factory Recipient.fromJson(Map<String, dynamic> json) => _$RecipientFromJson(json);

  factory Recipient.mock() => Recipient(
        active: true,
        currency: 'GHS',
        domain: 'test',
        id: 58094107,
        integration: 1041461,
        name: 'RICHMOND MENSAH BLANKSON',
        recipientCode: 'RCP_wr8kqkfv4tj27q6',
        type: 'ghipss',
        details: Details.mock(),
      );

  factory Recipient.empty() => Recipient(
        active: false,
        currency: '',
        domain: '',
        id: 0,
        integration: 0,
        name: '',
        recipientCode: '',
        type: '',
        details: Details.empty(),
      );
}

@freezed
class Details with _$Details {
  const factory Details({
    @JsonKey(name: 'authorization_code') String? authorizationCode,
    @JsonKey(name: 'account_number') required String accountNumber,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'bank_code') required String bankCode,
    @JsonKey(name: 'bank_name') required String bankName,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);

  factory Details.mock() =>
      const Details(accountNumber: '2100757371513', bankCode: '240100', bankName: 'Fidelity Bank Ghana Limited');

  factory Details.empty() => const Details(
        accountNumber: '',
        bankCode: '',
        bankName: '',
      );
}
