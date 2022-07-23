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
  static String conversion(String symbol, double amount) =>
      'networks/convert/$symbol/$amount';
}
