// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';
part 'transfer.g.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    @JsonKey(name: 'domain') String? domain,
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'reference') required String reference,
    @JsonKey(name: 'source') required String source,
    @JsonKey(name: 'source_details') String? sourceDetails,
    @JsonKey(name: 'reason') String? reason,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'transfer_code') required String transferCode,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'integration') int? integration,
    @JsonKey(name: 'recipient') int? recipient,
  }) = _Transfer;

  const Transfer._();

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);

  factory Transfer.mock() => const Transfer(
        domain: 'test',
        amount: 1000000,
        currency: 'NGN',
        reference: 'n7ll9pzl6b',
        source: 'balance',
        reason: 'E go better for you',
        status: 'success',
        transferCode: 'TRF_zuirlnr9qblgfko',
        id: 529410,
        integration: 123460,
        recipient: 225204,
      );

  factory Transfer.empty() => const Transfer(
        domain: 'test',
        amount: 1000000,
        currency: 'NGN',
        reference: 'n7ll9pzl6b',
        source: 'balance',
        reason: 'E go better for you',
        status: 'success',
        transferCode: 'TRF_zuirlnr9qblgfko',
        id: 529410,
        integration: 123460,
        recipient: 225204,
      );
}
