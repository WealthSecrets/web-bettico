// ignore_for_file: invalid_annotation_target
import 'package:betticos/features/p2p_betting/data/models/sportmonks/steam/steam.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../time/time.dart';

part 'livescore.freezed.dart';
part 'livescore.g.dart';

@freezed
class LiveScore with _$LiveScore {
  const factory LiveScore({
    required int id,
    @JsonKey(name: 'league_id') required int leagueId,
    @JsonKey(name: 'season_id') int? seasonId,
    @JsonKey(name: 'stage_id') int? stageId,
    @JsonKey(name: 'round_id') int? roundId,
    @JsonKey(name: 'group_id') int? groupId,
    @JsonKey(name: 'aggregate_id') int? aggregateId,
    @JsonKey(name: 'venue_id') int? venueId,
    @JsonKey(name: 'referee_id') int? refereeId,
    @JsonKey(name: 'localteam_id') required int localTeamId,
    @JsonKey(name: 'visitorteam_id') required int visitorTeamId,
    @JsonKey(name: 'winner_team_id') int? winnerTeamId,
    @JsonKey(name: 'commentaries') required bool commentaries,
    @JsonKey(name: 'neutral_venue') bool? neutralVenue,
    @JsonKey(name: 'localTeam') required Steam localTeam,
    @JsonKey(name: 'visitorTeam') required Steam visitorTeam,
    @JsonKey(name: 'winning_odds_calculated')
        required bool winningOddsCalculated,
    @JsonKey(name: 'formations') Formation? formations,
    @JsonKey(name: 'scores') Score? scores,
    @JsonKey(name: 'time') required Time time,
  }) = _LiveScore;

  const LiveScore._();

  factory LiveScore.fromJson(Map<String, dynamic> json) =>
      _$LiveScoreFromJson(json);

  factory LiveScore.mock() => LiveScore(
        id: 1,
        leagueId: 0,
        localTeamId: 0,
        visitorTeamId: 0,
        commentaries: false,
        winningOddsCalculated: false,
        localTeam: Steam.empty(),
        visitorTeam: Steam.empty(),
        time: Time.empty(),
      );

  factory LiveScore.empty() => LiveScore(
        id: 1,
        leagueId: 0,
        localTeamId: 0,
        visitorTeamId: 0,
        commentaries: false,
        winningOddsCalculated: false,
        localTeam: Steam.empty(),
        visitorTeam: Steam.empty(),
        time: Time.empty(),
      );
}

@freezed
class Formation with _$Formation {
  const factory Formation({
    @JsonKey(name: 'localteam_formation') String? localTeamFormation,
    @JsonKey(name: 'visitorteam_formation') String? visitorTeamFormation,
  }) = _Formation;

  factory Formation.fromJson(Map<String, dynamic> json) =>
      _$FormationFromJson(json);
}

@freezed
class Score with _$Score {
  const factory Score({
    @JsonKey(name: 'localteam_score') required int localTeamScore,
    @JsonKey(name: 'visitorteam_score') required int visitorTeamScore,
    @JsonKey(name: 'localteam_pen_score') int? localTeamPenScore,
    @JsonKey(name: 'visitorteam_pen_score') int? visitorTeamPenScore,
    @JsonKey(name: 'ht_score') String? htScore,
    @JsonKey(name: 'ft_score') String? ftScore,
    @JsonKey(name: 'et_score') String? etScore,
    @JsonKey(name: 'ps_score') String? psScore,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
