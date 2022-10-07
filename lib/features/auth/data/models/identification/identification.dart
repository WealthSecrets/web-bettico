// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'identification.freezed.dart';
part 'identification.g.dart';

@freezed
class Identification with _$Identification {
  const factory Identification({
    required String identificationType,
    required String identificationNumber,
    required DateTime expiryDate,
    required String url,
  }) = _Identification;

  const Identification._();

  factory Identification.fromJson(Map<String, dynamic> json) => _$IdentificationFromJson(json);

  factory Identification.mock() => Identification(
        expiryDate: Faker().date.dateTime(maxYear: 2100, minYear: 2022),
        identificationNumber: '${Faker().randomGenerator.integer(999999999, min: 100000000)}',
        identificationType: 'Passport',
        url: '',
      );

  factory Identification.empty() => Identification(
        expiryDate: DateTime.now(),
        identificationNumber: '',
        identificationType: '',
        url: '',
      );
}
