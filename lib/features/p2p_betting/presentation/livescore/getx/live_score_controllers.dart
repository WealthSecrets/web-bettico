import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/s_league_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/s_team_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/nullable_livescore_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/s_fixture_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_fixtures.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_leagues.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_livescores.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_paginated_fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/fetch_paginated_livescore.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_league.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_sfixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_slivescore.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/sportmonks/get_team.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import '/core/core.dart';
import '../../../../betticos/data/models/listpage/listpage.dart';

class LiveScoreController extends GetxController {
  LiveScoreController({
    required this.fetchPaginatedLiveScore,
    required this.fetchLiveScores,
    required this.fetchFixtures,
    required this.fetchPaginatedFixtures,
    required this.fetchLeagues,
    required this.getTeam,
    required this.getSFixture,
    required this.getSLiveScore,
    required this.getLeague,
  });

  final FetchPaginatedLiveScore fetchPaginatedLiveScore;
  final FetchLiveScores fetchLiveScores;
  final FetchFixtures fetchFixtures;
  final FetchPaginatedFixtures fetchPaginatedFixtures;
  final FetchLeagues fetchLeagues;

  final GetTeam getTeam;
  final GetSFixture getSFixture;
  final GetSLiveScore getSLiveScore;
  final GetLeague getLeague;

  RxList<LiveScore> liveScores = <LiveScore>[].obs;
  RxList<LiveScore> sFixtures = <LiveScore>[].obs;
  RxList<SLeague> sLeagues = <SLeague>[].obs;
  Rx<SLeague> selectedLeague = SLeague.empty().obs;
  Rx<ListPage<LiveScore>> liveScoresL = ListPage<LiveScore>.empty().obs;
  Rx<ListPage<LiveScore>> sFixturesL = ListPage<LiveScore>.empty().obs;
  RxList<Fixture> fixtures = <Fixture>[].obs;
  RxList<Fixture> searchedFixtures = <Fixture>[].obs;
  RxInt pageK = 1.obs;

  RxString walletAddress = ''.obs;

  // RxBool wcConnected = false.obs;
  // RxBool isWalletConnected = false.obs;
  RxBool isCompleted = false.obs;

  RxBool showLoadingLogo = false.obs;
  // RxBool isConnectingWallet = false.obs;
  // RxBool isMakingPayment = false.obs;
  RxList<String> closingBetID = <String>[].obs;
  RxString randomMessage = ''.obs;

  static const int operatingChain = 56;

  final WalletConnectProvider wc = WalletConnectProvider.binance();

  Web3Provider? web3wc;
  Contract? contract;

  RxString apiKey = ''.obs;
  RxString secretKey = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isFetchingLeagues = false.obs;
  RxBool isFetchingSFixture = false.obs;
  RxBool isFetchingLiveScores = false.obs;
  RxBool isFetchingFixtures = false.obs;

  void setSelectedLeague(SLeague league) {
    selectedLeague.value = league;
    getLiveScores();
    getSFixtures();
  }

  void getAllLeagues() async {
    isFetchingLeagues(true);
    final Either<Failure, List<SLeague>> failureOrLeagues = await fetchLeagues(NoParams());
    failureOrLeagues.fold<void>(
      (Failure failure) {
        isFetchingLeagues(false);
      },
      (List<SLeague> value) {
        isFetchingLeagues(false);

        sLeagues(value);
        if (value.isNotEmpty) {
          setSelectedLeague(value[0]);
        }
      },
    );
  }

  void getLiveScores() async {
    isFetchingLiveScores(true);
    final Either<Failure, List<LiveScore>> failureOrLiveScores =
        await fetchLiveScores(NullLiveScoreRequest(leagueId: selectedLeague.value.id));
    failureOrLiveScores.fold<void>(
      (Failure failure) {
        isFetchingLiveScores(false);
      },
      (List<LiveScore> value) {
        isFetchingLiveScores(false);
        final List<LiveScore> copyLiveScores = List<LiveScore>.from(value);
        copyLiveScores.removeWhere((LiveScore l) => l.time.status?.toLowerCase() == 'ft');
        liveScores.value = copyLiveScores;
      },
    );
  }

  void getSFixtures() async {
    isFetchingFixtures(true);
    final Either<Failure, List<LiveScore>> failureOrSFixtures =
        await fetchFixtures(NullLiveScoreRequest(leagueId: selectedLeague.value.id));
    failureOrSFixtures.fold<void>(
      (Failure failure) {
        isFetchingFixtures(false);
      },
      (List<LiveScore> value) {
        isFetchingFixtures(false);
        final DateTime now = DateTime.now();
        final DateTime today = DateTime(now.year, now.month, now.day);

        final List<LiveScore> copyLiveScores = List<LiveScore>.from(value);
        copyLiveScores.removeWhere((LiveScore l) {
          final DateTime lDateTime = DateTime.parse(
            l.time.startingAt.dateTime,
          );
          return lDateTime.isBefore(today);
        });
        sFixtures.value = copyLiveScores;
      },
    );
  }

  Future<Team?> getMatchTeam(int teamId) async {
    isFetchingLeagues(true);
    final Either<Failure, Team> failureOrTeam = await getTeam(
      STeamRequest(teamId: teamId),
    );
    return failureOrTeam.fold<Team?>(
      (Failure failure) {
        isFetchingLeagues(false);
        return null;
      },
      (Team value) {
        isFetchingLeagues(false);
        return value;
      },
    );
  }

  Future<LiveScore?> getMatchSFixture(int fixtureId) async {
    isFetchingSFixture(true);
    final Either<Failure, LiveScore> failureOrLiveScore = await getSFixture(
      SFixtureRequest(fixtureId: fixtureId),
    );
    return failureOrLiveScore.fold<LiveScore?>(
      (Failure failure) {
        isFetchingSFixture(false);
        return null;
      },
      (LiveScore value) {
        isFetchingSFixture(false);
        return value;
      },
    );
  }

  Future<LiveScore?> getMatchSLiveScore(int liveScoreId) async {
    isFetchingSFixture(true);
    final Either<Failure, LiveScore> failureOrLiveScore = await getSLiveScore(
      SFixtureRequest(fixtureId: liveScoreId),
    );
    return failureOrLiveScore.fold<LiveScore?>(
      (Failure failure) {
        isFetchingSFixture(false);
        return null;
      },
      (LiveScore value) {
        isFetchingSFixture(false);
        return value;
      },
    );
  }

  Future<SLeague?> getLeagueById(int leagueId) async {
    isFetchingLeagues(true);
    final Either<Failure, SLeague> failureOrLeague = await getLeague(
      SLeagueRequest(leagueId: leagueId),
    );
    return failureOrLeague.fold<SLeague?>(
      (Failure failure) {
        isFetchingLeagues(false);
        return null;
      },
      (SLeague value) {
        isFetchingLeagues(false);
        return value;
      },
    );
  }
}
