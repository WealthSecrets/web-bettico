import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_update_request.dart';

abstract class P2pRemoteDataSource {
  Future<List<SoccerMatch>> getLiveMatches(
    String apiKey,
    String secretKey,
  );

  Future<List<Fixture>> getFixtures(
    String apiKey,
    String secretKey,
  );

  Future<Bet> addBet({required BetRequest request});

  Future<Bet> updateBet(
      {required BetUpdateRequest request, required String betId});

  Future<List<Bet>> fetchBets();

  Future<List<Bet>> fetchAwaitingBets();

  Future<List<Bet>> fetchMyBets();

  Future<SoccerMatch?> getFixture(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
    String date,
  );

  Future<SoccerMatch?> getCompetitionMatch(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
  );

  Future<SoccerMatch?> getTeamMatch(
    String apiKey,
    String secretKey,
    int teamId,
    int competitionId,
    String date,
  );
}
