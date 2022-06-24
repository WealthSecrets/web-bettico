// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required int id,
    required String name,
    required String flag,
  }) = _Country;

  const Country._();

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  factory Country.mock() => Country(
        id: 1,
        name: Faker().person.name(),
        flag: 'RUS.png',
      );

  factory Country.empty() => const Country(
        id: 0,
        name: '',
        flag: '',
      );
}
