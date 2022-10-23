// ignore_for_file: invalid_annotation_target

import 'package:betticos/features/p2p_betting/domain/requests/bet/bettor_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/team_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_request.freezed.dart';
part 'bet_request.g.dart';

@freezed
class BetRequest with _$BetRequest {
  const factory BetRequest({
    required double amount,
    required int competitionId,
    required BettorRequest creator,
    BettorRequest? opponent,
    required TeamRequest awayTeam,
    required TeamRequest homeTeam,
    required String txthash,
    String? status,
    String? date,
    String? time,
    String? score,
    bool? isFixture,
  }) = _BetRequest;
  factory BetRequest.fromJson(Map<String, dynamic> json) =>
      _$BetRequestFromJson(json);
}
