import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/bet_update_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/user_bonus_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_update_request.dart';

import '../../../betticos/data/models/listpage/listpage.dart';
import '../../domain/requests/bet/update_bet_payout_request.dart';
import '../../domain/requests/bet/update_bet_status_score_request.dart';
import '../models/crypto/network.dart';
import '../models/crypto/volume.dart';

abstract class P2pRemoteDataSource {
  Future<List<SoccerMatch>> getLiveMatches(
    String apiKey,
    String secretKey,
  );

  Future<List<Fixture>> getFixtures(
    String apiKey,
    String secretKey,
  );

  Future<List<Network>> fetchCryptoNetworks();

  Future<Volume> convertAmount(String symbol, double amount);

  Future<Bet> addBet({required BetRequest request});

  Future<Transaction> addTransaction({required TransactionRequest request});

  Future<Bet> updateBet(
      {required BetUpdateRequest request, required String betId});

  Future<Transaction> updateTransaction(
      {required TransactionUpdateRequest request, required String hash});

  Future<Bet> updateBetStatusScore({
    required UpdateBetStatusScoreRequest request,
    required String betId,
  });

  Future<UserStats> getUserStats();

  Future<Bet> updateBetPayoutStatus({
    required UpdateBetPayoutRequest request,
    required String betId,
  });

  Future<List<Bet>> fetchBets();

  Future<List<Bet>> fetchStatusBets(String status);

  Future<List<Bet>> fetchMyBets(String status);

  Future<List<Transaction>> fetchMyTransactions(String userId);

  Future<List<Transaction>> fetchMyDeposits(String userId);

  Future<List<Transaction>> fetchMyWithdrawals(String userId);

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

  Future<Team> getTeam(int teamId);

  Future<User> updateBonus(UserBonusRequest request);

  Future<SLeague> getLeague(int leagueId);

  Future<LiveScore> getSFixture(int fixtureId);

  Future<LiveScore> getSLiveScore(int fixtureId);

  Future<List<SLeague>> fetchLeagues();

  Future<ListPage<LiveScore>> fetchPaginatedLiveScores(
    int page,
    int limit,
    int leagueId,
  );

  Future<List<LiveScore>> fetchLiveScores({int leagueId});

  Future<List<LiveScore>> fetchFixtures(int leagueId);

  Future<ListPage<LiveScore>> fetchPaginatedFixtures(
    int page,
    int limit,
    int leagueId,
  );

  Future<List<Bet>> getFilteredBets({
    String? status,
    required String title,
    String? from,
    String? to,
  });
}
