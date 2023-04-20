class P2pEndpoints {
  static const String bets = 'bets';
  static String updateBet(String betId) => 'bets/$betId';
  static String statusBets(String status) => 'bets/status/$status';
  static const String ongoingBets = 'bets/ongoing';
  static String myBets(String status) => 'bets/mybets/$status';
  static const String networks = 'networks';
  static String paginateLiveScore({
    required int page,
    required int size,
    required int leagueId,
  }) =>
      'sportmonks/livescores?page=$page&size=$size&leagues=$leagueId&include=localTeam,visitorTeam';

  static String liveScores({int? leagueId}) => 'sportmonks/livescores${leagueId != null ? '?leagues=$leagueId' : ''}';

  static String spaginateFixtures({
    required int page,
    required int size,
    required int leagueId,
  }) =>
      'sportmonks/fixtures?page=$page&size=$size&leagues=$leagueId&include=localTeam,visitorTeam';

  static String sFixtures({int? leagueId}) => 'sportmonks/fixtures${leagueId != null ? '?leagues=$leagueId' : ''}';

  static const String leagues = 'sportmonks/leagues';
  static const String userBonus = 'users/bonus';
  static String getTeam(int teamId) => 'sportmonks/team/$teamId';
  static String getLeague(int leagueId) => 'sportmonks/league/$leagueId';
  static String getSFixture(int fixtureId) => 'sportmonks/fixtures/$fixtureId?include=localTeam,visitorTeam';
  static String getSLiveScore(int liveScoreId) => 'sportmonks/livescores/$liveScoreId?include=localTeam,visitorTeam';
  static String conversion(String symbol, double amount) => 'networks/convert/$symbol/$amount';
  static String filteredBets({
    String? status,
    required String title,
    String? from,
    String? to,
  }) =>
      'bets/search?${status != null ? 'status=$status&' : ''}${title.isNotEmpty ? '&title=$title' : ''}${from != null ? '&from=$from' : ''}${to != null ? '&to=$to' : ''}';
}
