import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class P2pRepositoryImpl extends Repository implements P2pRepository {
  P2pRepositoryImpl({
    required this.p2pRemoteDataSource,
    required this.authLocalDataSource,
  });

  final P2pRemoteDataSource p2pRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, Bet>> addBet({
    required double amount,
    required int competitionId,
    String? status,
    required BettorRequest creator,
    BettorRequest? opponent,
    required TeamRequest awayTeam,
    required TeamRequest homeTeam,
    String? date,
    String? time,
    String? score,
    bool? isFixture,
  }) =>
      makeRequest(
        p2pRemoteDataSource.addBet(
          request: BetRequest(
            amount: amount,
            competitionId: competitionId,
            creator: creator,
            opponent: opponent,
            awayTeam: awayTeam,
            homeTeam: homeTeam,
            isFixture: isFixture,
            score: score,
            date: date,
            time: time,
          ),
        ),
      );

  @override
  Future<Either<Failure, Transaction>> addTransaction({
    String? betId,
    required String userId,
    required String type,
    required double amount,
    required double convertedAmount,
    required String transactionHash,
    required String walletAddress,
    required String description,
    required String status,
    required String token,
    required String convertedToken,
    DateTime? time,
    String? provider,
    double? gas,
  }) =>
      makeRequest(
        p2pRemoteDataSource.addTransaction(
          request: TransactionRequest(
            amount: amount,
            betId: betId,
            userId: userId,
            type: type,
            description: description,
            transactionHash: transactionHash,
            walletAddress: walletAddress,
            status: status,
            provider: provider,
            convertedAmount: convertedAmount,
            convertedToken: convertedToken,
            token: token,
            gas: gas,
            time: time,
          ),
        ),
      );

  @override
  Future<Either<Failure, Bet>> updateBet({
    required String betId,
    required String status,
    required BettorRequest opponent,
  }) =>
      makeRequest(
        p2pRemoteDataSource.updateBet(request: BetUpdateRequest(opponent: opponent, status: status), betId: betId),
      );

  @override
  Future<Either<Failure, Transaction>> updateTransaction({
    required String hash,
    required String betId,
  }) =>
      makeRequest(
        p2pRemoteDataSource.updateTransaction(request: TransactionUpdateRequest(betId: betId), hash: hash),
      );

  @override
  Future<Either<Failure, Bet>> updateBetStatusScore({
    required String betId,
    required String status,
    required String score,
  }) =>
      makeRequest(
        p2pRemoteDataSource.updateBetStatusScore(
          request: UpdateBetStatusScoreRequest(betId: betId, status: status, score: score),
          betId: betId,
        ),
      );

  @override
  Future<Either<Failure, Bet>> updateBetPayoutStatus({
    required String betId,
    required String status,
    required bool payout,
    required String txthash,
  }) =>
      makeRequest(
        p2pRemoteDataSource.updateBetPayoutStatus(
          request: UpdateBetPayoutRequest(
            betId: betId,
            status: status,
            payout: payout,
            txthash: txthash,
          ),
          betId: betId,
        ),
      );

  @override
  Future<Either<Failure, List<Bet>>> fetchBets() => makeRequest(p2pRemoteDataSource.fetchBets());

  @override
  Future<Either<Failure, UserStats?>> getUserStats() => makeRequest(p2pRemoteDataSource.getUserStats());

  @override
  Future<Either<Failure, List<SLeague>>> fetchLeagues() => makeRequest(p2pRemoteDataSource.fetchLeagues());

  @override
  Future<Either<Failure, List<Bet>>> fetchStatusBets(String status) =>
      makeRequest(p2pRemoteDataSource.fetchStatusBets(status));

  @override
  Future<Either<Failure, List<Bet>>> fetchMyBets(String status) => makeRequest(p2pRemoteDataSource.fetchMyBets(status));

  @override
  Future<Either<Failure, List<Transaction>>> fetchMyTransactions(
    String userId,
  ) =>
      makeRequest(p2pRemoteDataSource.fetchMyTransactions(userId));

  @override
  Future<Either<Failure, List<Network>>> fetchCryptoNetworks() =>
      makeRequest(p2pRemoteDataSource.fetchCryptoNetworks());

  @override
  Future<Either<Failure, Volume>> convertAmount(String symbol, double amount) =>
      makeRequest(p2pRemoteDataSource.convertAmount(symbol, amount));

  @override
  Future<Either<Failure, ListPage<LiveScore>>> fetchPaginatedLiveScores(
    int page,
    int limit,
    int leagueId,
  ) =>
      makeRequest(p2pRemoteDataSource.fetchPaginatedLiveScores(page, limit, leagueId));

  @override
  Future<Either<Failure, List<LiveScore>>> fetchLiveScores({int? leagueId}) =>
      makeRequest(p2pRemoteDataSource.fetchLiveScores(leagueId: leagueId));

  @override
  Future<Either<Failure, List<LiveScore>>> fetchFixtures({int? leagueId}) =>
      makeRequest(p2pRemoteDataSource.fetchFixtures(leagueId: leagueId));

  @override
  Future<Either<Failure, ListPage<LiveScore>>> fetchPaginatedFixtures(
    int page,
    int limit,
    int leagueId,
  ) =>
      makeRequest(p2pRemoteDataSource.fetchPaginatedFixtures(page, limit, leagueId));

  @override
  Future<Either<Failure, Team>> getTeam(int teamId) => makeRequest(p2pRemoteDataSource.getTeam(teamId));

  @override
  Future<Either<Failure, User>> updateUserBonus({required String type, required double amount}) async {
    final Either<Failure, User> response = await makeRequest(
      p2pRemoteDataSource.updateBonus(UserBonusRequest(type: type, amount: amount)),
    );

    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, List<Bet>>> getFilteredBets({
    String? status,
    required String title,
    String? from,
    String? to,
  }) {
    return makeRequest(
      p2pRemoteDataSource.getFilteredBets(
        status: status,
        title: title,
        from: from,
        to: to,
      ),
    );
  }

  @override
  Future<Either<Failure, SLeague>> getLeague(int leagueId) => makeRequest(p2pRemoteDataSource.getLeague(leagueId));

  @override
  Future<Either<Failure, LiveScore>> getSFixture(int fixtureId) =>
      makeRequest(p2pRemoteDataSource.getSFixture(fixtureId));

  @override
  Future<Either<Failure, LiveScore>> getSLiveScore(int liveScoreId) =>
      makeRequest(p2pRemoteDataSource.getSLiveScore(liveScoreId));
}
