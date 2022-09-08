import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import '/core/utils/http_client.dart';
import '/features/p2p_betting/data/data_sources/p2p_remote_data_source.dart';
import '/features/p2p_betting/data/endpoints/p2p_endpoints.dart';
import '/features/p2p_betting/data/models/fixture/fixture.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import '/features/p2p_betting/domain/requests/bet/bet_request.dart';
import '/features/p2p_betting/domain/requests/bet/bet_update_request.dart';
import '../../../betticos/data/models/listpage/listpage.dart';
import '../models/bet/bet.dart';
import '../models/crypto/network.dart';
import '../models/crypto/volume.dart';

class P2pRemoteDataSourceImpl implements P2pRemoteDataSource {
  const P2pRemoteDataSourceImpl({required AppHTTPClient client})
      : _client = client;
  final AppHTTPClient _client;

  @override
  Future<List<SoccerMatch>> getLiveMatches(
      String apiKey, String secretKey) async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.liveMatches(apiKey, secretKey));
    final List<dynamic> items = json['match'] as List<dynamic>;
    return List<SoccerMatch>.from(
      items.map<SoccerMatch>(
        (dynamic json) => SoccerMatch.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Fixture>> getFixtures(String apiKey, String secretKey) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.fixtures(
        apiKey,
        secretKey,
      ),
    );
    final List<dynamic> items = json['fixtures'] as List<dynamic>;
    return List<Fixture>.from(
      items.map<Fixture>(
        (dynamic json) => Fixture.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<SoccerMatch?> getFixture(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
    String date,
  ) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.fixture(
        apiKey,
        secretKey,
        competitionId,
        teamId,
        date,
      ),
    );
    final List<dynamic> items = json['fixtures'] as List<dynamic>;
    if (items.isNotEmpty) {
      return SoccerMatch.fromJson((items.first as Map<String, dynamic>));
    } else {
      return null;
    }
  }

  @override
  Future<Team> getTeam(int teamId) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.getTeam(teamId),
    );

    return Team.fromJson(json);
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
  Future<SoccerMatch?> getCompetitionMatch(
    String apiKey,
    String secretKey,
    int competitionId,
    int teamId,
  ) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.competitionMatches(
        apiKey,
        secretKey,
        competitionId,
        teamId,
      ),
    );
    final List<dynamic> items = json['match'] as List<dynamic>;
    if (items.isNotEmpty) {
      return SoccerMatch.fromJson(items.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  @override
  Future<SoccerMatch?> getTeamMatch(
    String apiKey,
    String secretKey,
    int teamId,
    int competitionId,
    String date,
  ) async {
    final Map<String, dynamic> json = await _client.get(
      P2pEndpoints.teamMatch(
        apiKey,
        secretKey,
        teamId,
        competitionId,
        date,
      ),
    );
    if ((json['match'] as List<dynamic>).isNotEmpty) {
      return SoccerMatch.fromJson(
          (json['match'] as List<dynamic>).first as Map<String, dynamic>);
    } else {
      return null;
    }
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
  Future<Bet> updateBet(
      {required BetUpdateRequest request, required String betId}) async {
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
  Future<List<Bet>> fetchAwaitingBets() async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.awaitingBets);
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
  Future<List<Bet>> fetchMyBets() async {
    final Map<String, dynamic> json = await _client.get(P2pEndpoints.myBets);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bet>.from(
      items.map<Bet>(
        (dynamic json) => Bet.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<LiveScore>> fetchLiveScores(int leagueId) async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.liveScore(leagueId: leagueId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<LiveScore>> fetchFixtures(int leagueId) async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.sFixtures(leagueId: leagueId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<LiveScore>.from(
      items.map<LiveScore>(
        (dynamic json) => LiveScore.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<ListPage<LiveScore>> fetchPaginatedLiveScores(
      int page, int limit, int leagueId) async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.paginateLiveScore(
      page: page,
      size: limit,
      leagueId: leagueId,
    ));
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
  Future<ListPage<LiveScore>> fetchPaginatedFixtures(
      int page, int limit, int leagueId) async {
    final Map<String, dynamic> json =
        await _client.get(P2pEndpoints.spaginateFixtures(
      page: page,
      size: limit,
      leagueId: leagueId,
    ));
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
