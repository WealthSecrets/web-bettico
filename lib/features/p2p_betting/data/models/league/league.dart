// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

@freezed
class League with _$League {
  const factory League({
    required int id,
    required String name,
    @JsonKey(name: 'country_id') required int countryId,
  }) = _League;

  const League._();

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  factory League.mock() => League(
        id: 1,
        name: Faker().person.name(),
        countryId: 0,
      );

  factory League.empty() => const League(
        countryId: 0,
        id: 0,
        name: '',
      );
}
