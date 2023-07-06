import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:betticos/features/p2p_betting/data/endpoints/transaction_endpoints.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_payout_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/user_bonus_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_update_request.dart';

import '/core/utils/http_client.dart';
import '/features/p2p_betting/data/data_sources/p2p_remote_data_source.dart';
import '/features/p2p_betting/data/endpoints/p2p_endpoints.dart';
import '/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import '/features/p2p_betting/domain/requests/bet/bet_request.dart';
import '/features/p2p_betting/domain/requests/bet/bet_update_request.dart';
import '../../../betticos/data/models/listpage/listpage.dart';
import '../../domain/requests/bet/update_bet_status_score_request.dart';
import '../models/bet/bet.dart';
import '../models/crypto/network.dart';
import '../models/crypto/volume.dart';

class P2pRemoteDataSourceImpl implements P2pRemoteDataSource {
  const P2pRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<Team> getTeam(int teamId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.getTeam(teamId),
    );

    return Team.fromJson(json);
  }

  @override
  Future<User> updateBonus(UserBonusRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      P2pEndpoints.userBonus,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<SLeague> getLeague(int leagueId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.getLeague(leagueId),
    );

    return SLeague.fromJson(json);
  }

  @override
  Future<LiveScore> getSFixture(int fixtureId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.getSFixture(fixtureId),
    );

    return LiveScore.fromJson(json);
  }

  @override
  Future<LiveScore> getSLiveScore(int liveScoreId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.getSLiveScore(liveScoreId),
    );

    return LiveScore.fromJson(json);
  }

  @override
  Future<Bet> addBet({required BetRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      P2pEndpoints.bets,
      body: request.toJson(),
    );
    return Bet.fromJson(json);
  }

  @override
  Future<Transaction> addTransaction({
    required TransactionRequest request,
  }) async {
    final Map<String, dynamic> json = await _client.post(TransactionEndpoints.transactions, body: request.toJson());
    return Transaction.fromJson(json);
  }

  @override
  Future<Bet> updateBet({required BetUpdateRequest request, required String betId}) async {
    final Map<String, dynamic> json = await _client.patch(
      P2pEndpoints.updateBet(betId),
      body: request.toJson(),
    );
    return Bet.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<UserStats?> getUserStats() async {
    final Map<String, dynamic> json = await _client.get(TransactionEndpoints.userStats);
    if (json.isEmpty) {
      return null;
    }
    return UserStats.fromJson(json);
  }

  @override
  Future<Transaction> updateTransaction({required TransactionUpdateRequest request, required String hash}) async {
    final Map<String, dynamic> json = await _client.patch(
      TransactionEndpoints.updateTransaction(hash),
      body: request.toJson(),
    );
    return Transaction.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Bet> updateBetStatusScore({
    required UpdateBetStatusScoreRequest request,
    required String betId,
  }) async {
    final Map<String, dynamic> json = await _client.patch(
      P2pEndpoints.updateBet(betId),
      body: request.toJson(),
    );
    return Bet.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Bet> updateBetPayoutStatus({
    required UpdateBetPayoutRequest request,
    required String betId,
  }) async {
    final Map<String, dynamic> json = await _client.patch(
      P2pEndpoints.updateBet(betId),
      body: request.toJson(),
    );
    return Bet.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Bet>> fetchBets() async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.bets);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bet>.from(
      items.map<Bet>(
        (dynamic json) => Bet.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Bet>> fetchStatusBets(String status) async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.statusBets(status));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bet>.from(
      items.map<Bet>(
        (dynamic json) => Bet.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Network>> fetchCryptoNetworks() async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.networks);
    final List<dynamic> items = json['data'] as List<dynamic>;
    return List<Network>.from(
      items.map<Network>(
        (dynamic json) => Network.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<Volume> convertAmount(String symbol, double amount) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.conversion(symbol.toLowerCase(), amount),
    );
    return Volume.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Bet>> fetchMyBets(String status) async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.myBets(status));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bet>.from(
      items.map<Bet>(
        (dynamic json) => Bet.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Transaction>> fetchMyTransactions(String userId) async {
    final Map<String, dynamic> json = await _client.get(TransactionEndpoints.userTransactions(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Transaction>.from(
      items.map<Transaction>((dynamic json) => Transaction.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<Transaction>> fetchMyWithdrawals(String userId) async {
    final Map<String, dynamic> json = await _client.get(TransactionEndpoints.userWithdrawals(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Transaction>.from(
      items.map<Transaction>((dynamic json) => Transaction.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<Transaction>> fetchMyDeposits(String userId) async {
    final Map<String, dynamic> json = await _client.get(TransactionEndpoints.userDeposits(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Transaction>.from(
      items.map<Transaction>((dynamic json) => Transaction.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<LiveScore>> fetchLiveScores({int? leagueId}) async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.liveScores(leagueId: leagueId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<LiveScore>> fetchFixtures({int? leagueId}) async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.sFixtures(leagueId: leagueId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Bet>> getFilteredBets({
    String? status,
    required String title,
    String? from,
    String? to,
  }) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.filteredBets(
        title: title,
        status: status,
        from: from,
        to: to,
      ),
    );

    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bet>.from(
      items.map<Bet>((dynamic json) => Bet.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<ListPage<LiveScore>> fetchPaginatedLiveScores(int page, int limit, int leagueId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.paginateLiveScore(page: page, size: limit, leagueId: leagueId),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<LiveScore> posts = List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<LiveScore>(
      grandTotalCount: json['results'] as int,
      itemList: posts,
    );
  }

  @override
  Future<ListPage<LiveScore>> fetchPaginatedFixtures(int page, int limit, int leagueId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.spaginateFixtures(page: page, size: limit, leagueId: leagueId),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<LiveScore> posts = List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<LiveScore>(grandTotalCount: json['results'] as int, itemList: posts);
  }

  @override
  Future<List<SLeague>> fetchLeagues() async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.leagues);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<SLeague>.from(
      items.map<SLeague>(
        (dynamic json) => SLeague.fromJson(json as Map<String, dynamic>),
      ),
    );
  }
}
