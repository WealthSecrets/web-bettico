import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

abstract class P2pRemoteDataSource {
  Future<List<Network>> fetchCryptoNetworks();

  Future<Volume> convertAmount(String symbol, double amount);

  Future<Bet> addBet({required BetRequest request});

  Future<Transaction> addTransaction({required TransactionRequest request});

  Future<Bet> updateBet({required BetUpdateRequest request, required String betId});

  Future<Transaction> updateTransaction({required TransactionUpdateRequest request, required String hash});

  Future<Bet> updateBetStatusScore({
    required UpdateBetStatusScoreRequest request,
    required String betId,
  });

  Future<UserStats?> getUserStats();

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

  Future<List<LiveScore>> fetchLiveScores({int? leagueId});

  Future<List<LiveScore>> fetchFixtures({int? leagueId});

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
