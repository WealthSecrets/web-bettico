// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleague.freezed.dart';
part 'sleague.g.dart';

@freezed
class SLeague with _$SLeague {
  const factory SLeague({
    required int id,
    required bool active,
    required String type,
    @JsonKey(name: 'legacy_id') int? legacyId,
    @JsonKey(name: 'country_id') int? countryId,
    @JsonKey(name: 'logo_path') required String logo,
    required String name,
    @JsonKey(name: 'is_cup') required bool isCup,
    @JsonKey(name: 'is_friendly') required bool isFriendly,
    @JsonKey(name: 'current_season_id') int? currentSeasonId,
    @JsonKey(name: 'current_round_id') int? currentRoundId,
    @JsonKey(name: 'current_stage_id') int? currentStageId,
  }) = _SLeague;

  const SLeague._();

  factory SLeague.fromJson(Map<String, dynamic> json) => _$SLeagueFromJson(json);

  factory SLeague.mock() => SLeague(
      id: 1, name: Faker().person.name(), active: false, logo: '', isCup: false, isFriendly: false, type: 'domestic');

  factory SLeague.empty() => SLeague(
      id: 1, name: Faker().person.name(), active: false, logo: '', isCup: false, isFriendly: false, type: 'domestic');
}
