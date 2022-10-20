class P2pEndpoints {
  static String liveMatches(String apiKey, String secretKey) =>
      'https://livescore-api.com/api-client/scores/live.json?key=$apiKey&secret=$secretKey';
  static String competitionMatches(
          String apiKey, String secretKey, int competitionId, int teamId) =>
      'https://livescore-api.com/api-client/scores/live.json?team_id=$teamId&compeition_id=$competitionId&key=$apiKey&secret=$secretKey';
  static String teamMatch(String apiKey, String secretKey, int teamId,
          int competitionId, String date) =>
      'https://livescore-api.com/api-client/scores/history.json?team_id=$teamId&competition_id=$competitionId&from=$date&to=$date&key=$apiKey&secret=$secretKey';

  static String fixtures(String apiKey, String secretKey) =>
      'https://livescore-api.com/api-client/fixtures/matches.json?key=$apiKey&secret=$secretKey';

  static String fixture(String apiKey, String secretKey, int competitionId,
          int teamId, String date) =>
      'https://livescore-api.com/api-client/fixtures/matches.json?competition_id=$competitionId&teamId=$teamId&date=$date&key=$apiKey&secret=$secretKey';
  static const String bets = 'bets';
  static String updateBet(String betId) => 'bets/$betId';
  static const String awaitingBets = 'bets/awaiting';
  static const String ongoingBets = 'bets/ongoing';
  static const String myBets = 'bets/mybets';
  static const String networks = 'networks';
  static String paginateLiveScore({
    required int page,
    required int size,
    required int leagueId,
  }) =>
      'sportmonks/livescores?page=$page&size=$size&leagues=$leagueId&include=localTeam,visitorTeam';

  static String liveScore({required int leagueId}) =>
      'sportmonks/livescores?leagues=$leagueId&include=localTeam,visitorTeam';

  static String spaginateFixtures({
    required int page,
    required int size,
    required int leagueId,
  }) =>
      'sportmonks/fixtures?page=$page&size=$size&leagues=$leagueId&include=localTeam,visitorTeam';

  static String sFixtures({required int leagueId}) =>
      'sportmonks/fixtures?leagues=$leagueId&include=localTeam,visitorTeam';

  static const String leagues = 'sportmonks/leagues';
  static const String userBonus = 'users/bonus';
  static String getTeam(int teamId) => 'sportmonks/team/$teamId';
  static String getLeague(int leagueId) => 'sportmonks/league/$leagueId';
  static String getSFixture(int fixtureId) =>
      'sportmonks/fixtures/$fixtureId?include=localTeam,visitorTeam';
  static String getSLiveScore(int liveScoreId) =>
      'sportmonks/livescores/$liveScoreId?include=localTeam,visitorTeam';
  static String conversion(String symbol, double amount) =>
      'networks/convert/$symbol/$amount';
}
