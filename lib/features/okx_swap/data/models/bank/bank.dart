// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank.freezed.dart';
part 'bank.g.dart';

@freezed
class Bank with _$Bank {
  const factory Bank({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'longcode') String? longCode,
    @JsonKey(name: 'pay_with_bank') bool? payWithBank,
    @JsonKey(name: 'gateway') String? gateway,
    @JsonKey(name: 'active') required bool active,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
  }) = _Bank;

  const Bank._();

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  factory Bank.mock() => const Bank(
        id: 50,
        name: 'Prudential Bank Limited',
        slug: 'prudential-bank-limited',
        code: '180100',
        longCode: '',
        payWithBank: false,
        active: true,
        country: 'Ghana',
        currency: 'GHS',
        type: 'ghipss',
        isDeleted: false,
      );

  factory Bank.empty() => const Bank(
        id: 0,
        name: '',
        slug: '',
        code: '',
        longCode: '',
        payWithBank: false,
        active: false,
        country: '',
        currency: '',
        type: '',
        isDeleted: false,
      );
}
