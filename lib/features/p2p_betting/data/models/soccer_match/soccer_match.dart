// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/p2p_betting/data/models/country/country.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'soccer_match.freezed.dart';
part 'soccer_match.g.dart';

enum SoccerMatchStatus {
  notStarted,
  inPlay,
  halfTimeBreak,
  addedTime,
  finished,
  insufficientData,
}

@freezed
class SoccerMatch with _$SoccerMatch {
  const factory SoccerMatch({
    required int id,
    String? scheduled,
    @JsonKey(name: 'competition_id') required int competitionId,
    @JsonKey(name: 'competition_name') String? competitionName,
    @JsonKey(name: 'ps_score') String? penaltyShootoutScore,
    required String location,
    DateTime? added,
    @JsonKey(name: 'away_id') required int awayId,
    @JsonKey(name: 'away_name') required String awayName,
    @JsonKey(name: 'et_score') String? extraTimeScore,
    String? events,
    @JsonKey(name: 'fixture_id') int? fixtureId,
    @JsonKey(name: 'ft_score') String? fullTimeScore,
    @JsonKey(name: 'h2h') String? head2head,
    @JsonKey(name: 'has_lineups') bool? hasLineups,
    @JsonKey(name: 'home_id') required int homeId,
    @JsonKey(name: 'home_name') required String homeName,
    @JsonKey(name: 'ht_score') String? halfTimeScore,
    @JsonKey(name: 'last_changed') DateTime? lastChanged,
    String? score,
    required String time,
    Country? country,
    String? info,
    @JsonKey(name: 'league_name') String? leagueName,
    @JsonKey(name: 'status') String? status,
  }) = _SoccerMatch;

  const SoccerMatch._();

  factory SoccerMatch.fromJson(Map<String, dynamic> json) => _$SoccerMatchFromJson(json);

  factory SoccerMatch.empty() => const SoccerMatch(
        awayId: 0,
        homeId: 0,
        awayName: '',
        homeName: '',
        competitionId: 0,
        competitionName: '',
        fixtureId: 0,
        fullTimeScore: '',
        halfTimeScore: '',
        hasLineups: false,
        id: 1,
        leagueName: '',
        location: '',
        scheduled: '',
        score: '',
        status: 'NOT STARTED',
        time: '',
      );
}
