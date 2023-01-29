import 'dart:convert';

import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/sleague/sleague.dart';
import 'package:betticos/features/p2p_betting/data/models/team/team.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/s_league_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/s_team_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/s_fixture_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/sportmonks/s_live_score_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixtures.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/usecases/live_score/get_live_matches.dart';
import '../../../../betticos/data/models/listpage/listpage.dart';
import '../../../data/models/crypto/volume.dart';
import '../../../domain/requests/crypto/convert_amount_request.dart';
import '../../../domain/requests/live_score/live_scores_request.dart';
import '../../../domain/usecases/crypto/convert_amount_to_currency.dart';

class LiveScoreController extends GetxController {
  LiveScoreController({
    required this.getLiveMatches,
    required this.getFixtures,
    required this.convertAmountToCurrency,
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

  final GetLiveMatches getLiveMatches;
  final FetchPaginatedLiveScore fetchPaginatedLiveScore;
  final FetchLiveScores fetchLiveScores;
  final FetchFixtures fetchFixtures;
  final FetchPaginatedFixtures fetchPaginatedFixtures;
  final FetchLeagues fetchLeagues;

  final GetFixtures getFixtures;
  final GetTeam getTeam;
  final GetSFixture getSFixture;
  final GetSLiveScore getSLiveScore;
  final GetLeague getLeague;

  final ConvertAmountToCurrency convertAmountToCurrency;

  RxList<SoccerMatch> matches = <SoccerMatch>[].obs;
  RxList<LiveScore> liveScores = <LiveScore>[].obs;
  RxList<LiveScore> sFixtures = <LiveScore>[].obs;
  RxList<SLeague> sLeagues = <SLeague>[].obs;
  Rx<SLeague> selectedLeague = SLeague.empty().obs;
  Rx<ListPage<LiveScore>> liveScoresL = ListPage<LiveScore>.empty().obs;
  Rx<ListPage<LiveScore>> sFixturesL = ListPage<LiveScore>.empty().obs;
  RxList<Fixture> fixtures = <Fixture>[].obs;
  RxList<Fixture> searchedFixtures = <Fixture>[].obs;
  RxList<SoccerMatch> sMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> finishedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> notStartedMatches = <SoccerMatch>[].obs;
  RxList<SoccerMatch> inPlayMatches = <SoccerMatch>[].obs;
  RxInt pageK = 1.obs;

  RxDouble convertedAmount = 0.0.obs;
  RxString walletAddress = ''.obs;
  RxInt currentChain = (-1).obs;
  RxBool wcConnected = false.obs;
  RxBool isWalletConnected = false.obs;
  RxBool isCompleted = false.obs;
  RxString selectedCurrency = 'wsc'.obs;
  RxBool showLoadingLogo = false.obs;
  RxBool isConnectingWallet = false.obs;
  RxList<String> closingBetID = <String>[].obs;

  static const int operatingChain = 56;

  final WalletConnectProvider wc = WalletConnectProvider.binance();

  Web3Provider? web3wc;

  RxString apiKey = ''.obs;
  RxString secretKey = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isFetchingLeagues = false.obs;
  RxBool isFetchingSFixture = false.obs;
  RxBool isFetchingLiveScores = false.obs;
  RxBool isFetchingFixtures = false.obs;

  Future<void> connectProvider([Function(String wallet)? func]) async {
    if (Ethereum.isSupported) {
      final List<String> accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        walletAddress.value = accs.first;
        currentChain.value = await ethereum!.getChainId();
        func?.call(accs.first);
      }

      update();
    }
  }

  Future<void> connectWC([Function(String wallet)? func]) async {
    isConnectingWallet.value = true;
    try {
      await wc.connect();

      if (wc.connected) {
        walletAddress.value = wc.accounts.first;
        currentChain.value = 56;
        web3wc = Web3Provider.fromWalletConnect(wc);
        wcConnected.value = true;
      }

      func?.call(wc.accounts.first);
      isConnectingWallet.value = false;
    } catch (error) {
      debugPrint('An error has occurred: $error');
      isConnectingWallet.value = false;
    }
    update();
  }

  void initiateWalletConnect([Function(String wallet)? func]) async {
    isConnectingWallet.value = true;
    if (Ethereum.isSupported) {
      await connectProvider(func);

      ethereum!.onAccountsChanged((List<String> accs) {
        disconnect();
      });

      ethereum!.onChainChanged((int chain) {
        disconnect();
      });
      isConnectingWallet.value = false;
    } else {
      await connectWC();
      isConnectingWallet.value = false;
    }
  }

  void disconnect() {
    wc.disconnect();
    walletAddress.value = '';
    currentChain.value = -1;
    wcConnected.value = false;
    web3wc = null;

    update();
  }

  Future<TransactionResponse?> send(BuildContext context) async {
    showLoadingLogo.value = true;

    final double amount = convertedAmount * 1000000000 * 1000000000;

    try {
      final String jsonText =
          await rootBundle.loadString('assets/keys/keys.json');
      final dynamic value = json.decode(jsonText);

      final String tokenAddress = value['token'] as String;
      final String depositAddress = value['depositAddress'] as String;

      final ContractERC20 token =
          ContractERC20(tokenAddress, web3wc!.getSigner());

      // TODO(blankson123): find a better way to handle callbacks for payments
      // ignore: unawaited_futures
      AppSnacks.show(
        context,
        message: 'Please check you wallet app to confirm payment',
        backgroundColor: context.colors.success,
        duration: const Duration(seconds: 5),
        leadingIcon: const Icon(
          Ionicons.checkmark_circle_sharp,
          size: 20,
          color: Colors.white,
        ),
      );

      final TransactionResponse response = await token.transfer(
        depositAddress,
        BigInt.from(amount.round()),
      );

      showLoadingLogo.value = false;
      return response;
    } catch (e) {
      showLoadingLogo.value = false;
      await AppSnacks.show(context,
          message: 'Couldn\'t make payment, please check your wallet balance');
      return null;
    }
  }

  Future<TransactionResponse?> payout(
    BuildContext context,
    String winningAddress,
    double payoutAmount,
    String betId,
  ) async {
    showLoadingLogo.value = true;
    closingBetID.add(betId);

    final double amount = convertedAmount * 1000000000 * 1000000000;

    final String jsonText =
        await rootBundle.loadString('assets/keys/keys.json');
    final dynamic value = json.decode(jsonText);

    final String tokenAddress = value['token'] as String;
    final String mnemonic = value['phrase'] as String;

    final Wallet wallet = Wallet.fromMnemonic(mnemonic);

    final JsonRpcProvider jsonRpcProvider =
        JsonRpcProvider('https://bsc-dataseed.binance.org/');
    final Wallet walletProvider = wallet.connect(jsonRpcProvider);

    final ContractERC20 token = ContractERC20(tokenAddress, walletProvider);

    try {
      final TransactionResponse response = await token.transfer(
        winningAddress,
        BigInt.from(amount.round()),
      );

      closingBetID.remove(betId);
      showLoadingLogo.value = false;
      return response;
    } catch (e) {
      showLoadingLogo.value = false;
      await AppSnacks.show(context, message: 'Sorry, cashout failed');
      return null;
    }
  }

  bool get isInOperatingChain => currentChain.value == operatingChain;

  bool get isConnected => walletAddress.value.isNotEmpty;

  void setSelectedLeague(SLeague league) {
    selectedLeague.value = league;
    getLiveScores();
    getSFixtures();
  }

  void getAllLiveMatches(BuildContext context) async {
    isLoading(true);
    final String response =
        await rootBundle.loadString('assets/keys/live_score.json');
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, List<SoccerMatch>> failureOrMatches =
        await getLiveMatches(
      LiveScoreRequest(
        apiKey: apiKey,
        secretKey: secretKey,
      ),
    );

    failureOrMatches.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<SoccerMatch> value) {
        isLoading(false);
        matches(value);
        if (matches.isNotEmpty) {
          getFilteredMatches('IN PLAY');
          getFilteredMatches('NOT STARTED');
          getFilteredMatches('FINISHED');
        }
      },
    );
  }

  void getAllLeagues() async {
    isFetchingLeagues(true);
    final Either<Failure, List<SLeague>> failureOrLeagues =
        await fetchLeagues(NoParams());
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
        await fetchLiveScores(
            SLiveScoreRequest(leagueId: selectedLeague.value.id));
    failureOrLiveScores.fold<void>(
      (Failure failure) {
        isFetchingLiveScores(false);
      },
      (List<LiveScore> value) {
        isFetchingLiveScores(false);
        final List<LiveScore> copyLiveScores = List<LiveScore>.from(value);
        copyLiveScores
            .removeWhere((LiveScore l) => l.time.status?.toLowerCase() == 'ft');
        liveScores.value = copyLiveScores;
      },
    );
  }

  void getSFixtures() async {
    isFetchingFixtures(true);
    final Either<Failure, List<LiveScore>> failureOrSFixtures =
        await fetchFixtures(
            SLiveScoreRequest(leagueId: selectedLeague.value.id));
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

  void setSelectedCurrency(String currency) {
    selectedCurrency.value = currency.toLowerCase();
  }

  void convertAmount(
    BuildContext context,
    String currency,
    double amount, {
    void Function()? failureCallback,
    void Function(double amount)? successCallback,
    String? betId,
  }) async {
    isLoading(true);
    if (betId != null) {
      closingBetID.add(betId);
    }

    setSelectedCurrency(currency);

    final Either<Failure, Volume> failureOrVolume =
        await convertAmountToCurrency(
            ConvertAmountRequest(amount: amount, currency: currency));

    failureOrVolume.fold<void>(
      (Failure failure) {
        isLoading(false);
        if (betId != null) {
          closingBetID.remove(betId);
        }
        AppSnacks.show(context, message: failure.message);
        failureCallback?.call();
      },
      (Volume vol) {
        isLoading(false);
        if (betId != null) {
          closingBetID.remove(betId);
        }
        convertedAmount.value = vol.convertedAmount;
        successCallback?.call(vol.convertedAmount);
      },
    );
  }

  void getAllFixtures(BuildContext context) async {
    isLoading(true);

    final String response =
        await rootBundle.loadString('assets/keys/live_score.json');
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, List<Fixture>> failureOrFixtures = await getFixtures(
      LiveScoreRequest(
        apiKey: apiKey,
        secretKey: secretKey,
      ),
    );

    failureOrFixtures.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Fixture> value) {
        isLoading(false);
        fixtures(value);
      },
    );
  }

  void getFilteredMatches(String filter) {
    final List<SoccerMatch> newMatches =
        matches.where((SoccerMatch match) => match.status == filter).toList();
    if (filter == 'FINISHED') {
      finishedMatches(newMatches);
    } else if (filter == 'IN PLAY') {
      inPlayMatches(newMatches);
    } else if (filter == 'NOT STARTED') {
      notStartedMatches(newMatches);
    }
  }

  void searchLiveMatchesAndFixtures(String query) async {
    isSearching(true);
    final List<SoccerMatch> ss = matches
        .where((SoccerMatch s) =>
            s.awayName.toLowerCase().contains(query) ||
            s.homeName.toLowerCase().contains(query))
        .toList();
    sMatches(ss);
    if (ss.isEmpty) {
      final List<Fixture> ff = fixtures
          .where((Fixture f) =>
              f.awayName.toLowerCase().contains(query) ||
              f.homeName.toLowerCase().contains(query))
          .toList();
      searchedFixtures(ff);
    }
  }
}
