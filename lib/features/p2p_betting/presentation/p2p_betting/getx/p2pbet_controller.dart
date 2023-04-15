import 'dart:convert';

import 'package:betticos/features/betticos/domain/requests/follow/user_request.dart';
import 'package:betticos/features/p2p_betting/data/models/fixture/fixture.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/search_bet_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/status_bets_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/team_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_payout_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/update_bet_status_score_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/live_score/fixture_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/live_score/live_competition_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/live_score/live_team_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_request.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_update_request.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/fetch_mybets.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/fetch_status_bets.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/search_bet.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_bet.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_bet_payout_status.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_bet_score_status.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_competition_match.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_fixture.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/live_score/get_team_match.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/transaction/add_transaction.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/transaction/get_user_transactions.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/transaction/update_transaction.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/p2p_betting/data/models/bet/bet.dart';
import '/features/p2p_betting/data/models/bettor/bettor.dart';
import '/features/p2p_betting/data/models/soccer_match/soccer_match.dart';
import '/features/p2p_betting/domain/requests/bet/bet_request.dart';
import '/features/p2p_betting/domain/requests/bet/bettor_request.dart';
import '/features/p2p_betting/domain/usecases/bet/add_bet.dart';
import '/features/p2p_betting/domain/usecases/bet/fetch_bets.dart';

class P2PBetController extends GetxController {
  P2PBetController({
    required this.addBet,
    required this.addTransaction,
    required this.updateTransaction,
    required this.getUserTransactions,
    required this.updateBet,
    required this.updateBetStatusScore,
    required this.updateBetPayoutStatus,
    required this.fetchBets,
    required this.fetchStatusBets,
    required this.fetchMyBets,
    required this.getCompetitionMatch,
    required this.getTeamMatch,
    required this.getFixture,
    required this.searchBets,
  });

  final AddBet addBet;
  final AddTransaction addTransaction;
  final UpdateTransaction updateTransaction;
  final GetUserTransactions getUserTransactions;
  final UpdateBet updateBet;
  final UpdateBetStatusScore updateBetStatusScore;
  final SearchBets searchBets;
  final UpdateBetPayoutStatus updateBetPayoutStatus;
  final FetchBets fetchBets;
  final FetchStatusBets fetchStatusBets;
  final FetchMyBets fetchMyBets;
  final GetCompetitionMatch getCompetitionMatch;
  final GetTeamMatch getTeamMatch;
  final GetFixture getFixture;

  Rx<Bet> bet = Bet.empty().obs;
  RxList<Bet> bets = <Bet>[].obs;
  RxList<Bet> myBets = <Bet>[].obs;
  RxList<Transaction> myTransactions = <Transaction>[].obs;
  RxString filterStatus = 'wins'.obs;
  Rx<SoccerMatch> match = SoccerMatch.empty().obs;
  Rx<Fixture> fixture = Fixture.empty().obs;
  Rx<LiveScore> liveScore = LiveScore.empty().obs;
  RxList<String> closingBetID = <String>[].obs;

  // loading states
  RxBool isAddingBet = false.obs;
  RxBool isAddingTransaction = false.obs;
  RxBool isUpdatingBet = false.obs;
  RxBool isAddingStatusToBet = false.obs;
  RxBool isClosingPayout = false.obs;
  RxBool isFetchingBets = false.obs;
  RxBool isFilteringBets = false.obs;
  RxBool isFetchingMyBets = false.obs;
  RxBool isFetchingTransactions = false.obs;
  RxBool isFetchingCompetitionMatches = false.obs;
  RxBool isFetchingLiveTeamMatch = false.obs;

  // Variables
  RxDouble amount = 0.0.obs;
  RxInt competitionId = (-1).obs;
  RxInt liveScoreId = (-1).obs;
  Rx<Bettor> creator = Bettor.empty().obs;
  Rx<Bettor> opponent = Bettor.empty().obs;
  RxString status = 'awaiting'.obs;
  RxString teamSelected = ''.obs;
  RxInt teamId = (-1).obs;
  RxString choice = ''.obs;
  RxString selectedButton = 'awaiting'.obs;

  // for filtering bets
  RxString title = ''.obs;
  RxString searchStatus = ''.obs;
  RxString paymentType = ''.obs;
  RxString from = ''.obs;
  RxString to = ''.obs;

  final List<String> buttonTexts = <String>['Awaiting', 'Ongoing', 'Completed'];

  // the base screen controller
  final BaseScreenController bController = Get.find<BaseScreenController>();

  void resetValues() {
    teamSelected('');
    teamId(-1);
    choice('');
    amount(0.0);
    paymentType('');
    competitionId(-1);
  }

  void selectTeam(String value, int id) {
    teamSelected(value);
    teamId(id);
  }

  void selectChoice(String value) {
    choice(value);
  }

  void setButtonSelected(BuildContext context, String value) {
    selectedButton(value);
    getAllStatusBets(context, value.toLowerCase());
  }

  void setCompetitionId(int value) {
    competitionId(value);
  }

  void setMatch(SoccerMatch value) {
    match(value);
  }

  void setFixture(Fixture value) {
    fixture(value);
  }

  void setLiveScoreId(int value) {}

  void setLiveScore(LiveScore value) {
    liveScore.value = value;
  }

  void onAmountInputChanged(double value) {
    amount(value);
  }

  String? validateFirstName(String? firstName) {
    String? errorMessage;
    if (firstName!.isEmpty) {
      errorMessage = 'Please enter your first name.';
    }

    return errorMessage;
  }

  Bet getBetById(String betId, {bool isMyBets = false}) {
    if (isMyBets) {
      return myBets.firstWhere((Bet b) => b.id == betId);
    }
    return bets.firstWhere((Bet b) => b.id == betId);
  }

  String? validateAmount(String stringAmount) {
    final double? amount = double.tryParse(stringAmount);
    if (amount == null) {
      return 'Invalid amount';
    }
    if (amount < 1) {
      return r'Minimum of $1';
    }
    if (amount > 1000) {
      return r'Maximum of $1,000';
    }
    return null;
  }

  bool get isValid =>
      teamId.value != -1 &&
      teamSelected.isNotEmpty &&
      choice.isNotEmpty &&
      paymentType.value.isNotEmpty &&
      validateAmount(amount.value.toString()) == null;

  bool get isDetailsValid =>
      choice.isNotEmpty &&
      teamId.value != -1 &&
      teamSelected.isNotEmpty &&
      paymentType.value.isNotEmpty;

  void addNewBet(BuildContext context, String wallet, String txthash) async {
    isAddingBet(true);
    final Either<Failure, Bet> failureOrBet = await addBet(
      BetRequest(
        amount: amount.value,
        competitionId: liveScore.value.id,
        creator: BettorRequest(
          choice: choice.value,
          team: teamSelected.value,
          teamId: teamId.value,
          user: bController.user.value.id,
          wallet: wallet,
          txthash: txthash,
        ),
        awayTeam: TeamRequest(
          name: liveScore.value.visitorTeam.data.name,
          teamId: liveScore.value.visitorTeam.data.id,
          logoPath: liveScore.value.visitorTeam.data.logo,
        ),
        homeTeam: TeamRequest(
          name: liveScore.value.localTeam.data.name,
          teamId: liveScore.value.localTeam.data.id,
          logoPath: liveScore.value.localTeam.data.logo,
        ),
        status: status.value,
        time: liveScore.value.time.startingAt.time,
        date: liveScore.value.time.startingAt.date,
        score: liveScore.value.scores!.ftScore ?? '? : ?',
        isFixture: false,
      ),
    );

    failureOrBet.fold<void>(
      (Failure failure) {
        isAddingBet(false);
      },
      (Bet value) {
        isAddingBet(false);
        updateBetTransaction(context, betId: value.id, hash: txthash);
        resetValues();
        bet(value);
        // TODO:(blankson123) when successful, update transaction via transaction hash
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const P2PBettingCongratScreen(),
          ),
        );
      },
    );
  }

  void createBetTransaction(
    BuildContext context, {
    String? betId,
    required double amount,
    required double convertedAmount,
    required String wallet,
    required String txthash,
    required String convertedToken,
    required String type,
    required String description,
    DateTime? time,
    String? provider,
    double? gas,
    Function()? callback,
  }) async {
    isAddingTransaction(true);

    final Either<Failure, Transaction> failureOrTransaction =
        await addTransaction(
      TransactionRequest(
        betId: betId,
        userId: bController.user.value.id,
        amount: amount,
        status: 'successful',
        description: description,
        transactionHash: txthash,
        walletAddress: wallet,
        type: type,
        provider: provider,
        time: time,
        convertedAmount: convertedAmount,
        convertedToken: convertedToken,
        token: 'usd',
        gas: gas,
      ),
    );

    failureOrTransaction.fold<void>(
      (Failure failure) {
        isAddingTransaction(false);
      },
      (Transaction transaction) {
        isAddingTransaction(false);
        callback?.call();
      },
    );
  }

  void updateBetTransaction(BuildContext context,
      {required String betId, required String hash}) async {
    isAddingTransaction(true);

    final Either<Failure, Transaction> failureOrTransaction =
        await updateTransaction(
      TransactionUpdateRequest(betId: betId, hash: hash),
    );

    failureOrTransaction.fold<void>(
      (Failure failure) {
        isAddingTransaction(false);
      },
      (Transaction transaction) {
        isAddingTransaction(false);
        //TODO:(blankson123) think of what to implement here.
      },
    );
  }

  void addOpponentToBet(
    BuildContext context,
    Bet b,
    String wallet,
    String txthash,
  ) async {
    isUpdatingBet(true);
    final Either<Failure, Bet> failureOrBet = await updateBet(
      UpdateBetRequest(
        betId: b.id,
        opponent: BettorRequest(
          choice: choice.value,
          team: teamSelected.value,
          teamId: teamId.value,
          user: bController.user.value.id,
          wallet: wallet,
          txthash: txthash,
        ),
        status: 'ongoing',
      ),
    );

    failureOrBet.fold<void>(
      (Failure failure) {
        isUpdatingBet(false);
      },
      (Bet value) {
        isUpdatingBet(false);
        bet(value);
        showAppModal<void>(
          barrierDismissible: false,
          context: context,
          alignment: Alignment.center,
          builder: (BuildContext modalContext) {
            return Center(
              child: SizedBox(
                width: 600,
                height: 500,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    AppDialogueModal(
                      icon: Icon(
                        Ionicons.checkmark_circle_sharp,
                        color: context.colors.success,
                        size: 60,
                      ),
                      description:
                          'You have successfully accepted this ${txthash == 'bonus' ? 'bet using your bonus.' : 'bet.'}',
                      title: Text(
                        'Bet Accepted',
                        style: TextStyle(
                          color: context.colors.success,
                          fontSize: 20,
                        ),
                      ),
                      buttonText: 'Dismiss',
                      onDismissed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addStatusScoreToBet({
    required String betId,
    required String score,
    required String status,
    String? winner,
  }) async {
    isAddingStatusToBet(true);

    String st = 'awaiting';

    if (status.toLowerCase() == 'live' ||
        status.toLowerCase() == 'h1' ||
        status.toLowerCase() == 'ht' ||
        status.toLowerCase() == 'h2') {
      st = 'ongoing';
    } else if (status.toLowerCase() == 'ft' ||
        status.toLowerCase() == 'completed') {
      st = 'completed';
    }

    final Either<Failure, Bet> failureOrBet = await updateBetStatusScore(
      UpdateBetStatusScoreRequest(
        betId: betId,
        score: score,
        status: st,
        winner: winner,
      ),
    );

    failureOrBet.fold<void>(
      (Failure failure) {
        isAddingStatusToBet(false);
      },
      (Bet value) {
        isAddingStatusToBet(false);
        final List<Bet> betCopy = List<Bet>.from(bets);
        final int valueIndex = betCopy.indexWhere((Bet b) => b.id == value.id);
        betCopy[valueIndex] = value;
        bets(betCopy);
      },
    );
  }

  void closePayout({
    required String betId,
    required String txthash,
    bool? isMyBets,
    Function()? callback,
  }) async {
    isClosingPayout(true);

    closingBetID.add(betId);

    const String status = 'completed';

    final Either<Failure, Bet> failureOrBet = await updateBetPayoutStatus(
      UpdateBetPayoutRequest(
        betId: betId,
        payout: true,
        status: status,
        txthash: txthash,
      ),
    );

    failureOrBet.fold<void>(
      (Failure failure) {
        isClosingPayout(false);
        closingBetID.remove(betId);
      },
      (Bet value) {
        isClosingPayout(false);
        closingBetID.remove(betId);
        callback?.call();
        if (isMyBets ?? false) {
          final List<Bet> betCopy = List<Bet>.from(myBets);
          final int valueIndex =
              betCopy.indexWhere((Bet b) => b.id == value.id);
          betCopy[valueIndex] = value;
          myBets.value = betCopy;
        } else {
          final List<Bet> betCopy = List<Bet>.from(bets);
          final int valueIndex =
              betCopy.indexWhere((Bet b) => b.id == value.id);
          betCopy[valueIndex] = value;
          bets.value = betCopy;
        }
        getMyBets(filterStatus.value);
      },
    );
  }

  Future<SoccerMatch?> getLiveCompetitionMatch(
    BuildContext context,
    int competitionId,
    int teamId,
  ) async {
    isFetchingCompetitionMatches(true);
    SoccerMatch? teamMatch;
    final String response = await rootBundle.loadString(AppAssetKeys.liveScore);
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, SoccerMatch?> failureOrMatches =
        await getCompetitionMatch(
      LiveCompetitionRequest(
        apiKey: apiKey,
        secretKey: secretKey,
        competitionId: competitionId,
        teamId: teamId,
      ),
    );

    failureOrMatches.fold<void>(
      (Failure failure) {
        isFetchingCompetitionMatches(false);
      },
      (SoccerMatch? value) {
        isFetchingCompetitionMatches(false);
        teamMatch = value;
      },
    );

    return Future<SoccerMatch?>.value(teamMatch);
  }

  Future<SoccerMatch?> getTeamFixture(
    BuildContext context,
    int competitionId,
    int teamId,
    String date,
  ) async {
    isFetchingCompetitionMatches(true);
    SoccerMatch? teamMatch;
    final String response = await rootBundle.loadString(AppAssetKeys.liveScore);
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    final Either<Failure, SoccerMatch?> failureOrMatches = await getFixture(
      FixtureRequest(
        apiKey: apiKey,
        secretKey: secretKey,
        competitionId: competitionId,
        teamId: teamId,
        date: date,
      ),
    );

    failureOrMatches.fold<void>(
      (Failure failure) {
        isFetchingCompetitionMatches(false);
      },
      (SoccerMatch? value) {
        isFetchingCompetitionMatches(false);
        teamMatch = value;
      },
    );

    return Future<SoccerMatch?>.value(teamMatch);
  }

  Future<SoccerMatch?> getLiveTeamMatch(
    BuildContext context,
    int teamId,
    int competitionId,
    String date, {
    bool? isFixture,
  }) async {
    SoccerMatch? teamMatch;
    isFetchingLiveTeamMatch(true);
    final String response = await rootBundle.loadString(AppAssetKeys.liveScore);
    final Map<String, dynamic> liveScoreKeys =
        await json.decode(response) as Map<String, dynamic>;
    final String apiKey = liveScoreKeys['api_key'] as String;
    final String secretKey = liveScoreKeys['secret_key'] as String;

    if (isFixture ?? false) {
      final SoccerMatch? sm =
          await getTeamFixture(context, competitionId, teamId, date);

      if (sm == null) {
        teamMatch = null;
      } else {
        teamMatch = sm;
      }
    } else {
      final Either<Failure, SoccerMatch?> failureOrMatche = await getTeamMatch(
        LiveTeamRequest(
          apiKey: apiKey,
          secretKey: secretKey,
          teamId: teamId,
          competitionId: competitionId,
          date: date,
        ),
      );

      failureOrMatche.fold<void>(
        (Failure failure) {
          isFetchingLiveTeamMatch(false);
        },
        (SoccerMatch? value) async {
          isFetchingLiveTeamMatch(false);
          if (value == null) {
            final SoccerMatch? sm =
                await getLiveCompetitionMatch(context, competitionId, teamId);

            if (sm == null) {
              // fetch fixtures
            } else {
              teamMatch = sm;
            }
          } else {
            teamMatch = value;
          }
        },
      );
    }

    return Future<SoccerMatch?>.value(teamMatch);
  }

  void getAllBs() async {
    isFetchingBets(true);

    final Either<Failure, List<Bet>> failureOrBets = await fetchBets(
      NoParams(),
    );

    failureOrBets.fold<void>(
      (Failure failure) {
        isFetchingBets(false);
      },
      (List<Bet> value) {
        isFetchingBets(false);
        bets(value);
      },
    );
  }

  void filterBets() async {
    isFetchingBets(true);

    final Either<Failure, List<Bet>> failureOrBets = await searchBets(
      SearchBetRequest(
          title: title.value,
          status: searchStatus.isEmpty ? null : searchStatus.value,
          from: from.isEmpty ? null : from.value,
          to: to.isEmpty ? null : to.value),
    );

    failureOrBets.fold<void>(
      (Failure failure) {
        isFetchingBets(false);
      },
      (List<Bet> value) {
        isFetchingBets(false);
        bets(value);
      },
    );
  }

  void clearFilter(BuildContext context) {
    title('');
    searchStatus('');
    from('');
    to('');
    getAllStatusBets(context, selectedButton.value);
  }

  bool get isFiltering =>
      title.isNotEmpty ||
      status.isNotEmpty ||
      (from.isNotEmpty && to.isNotEmpty);

  void resetSearch() {
    title('');
    searchStatus('');
    from('');
    to('');
  }

  void getAllStatusBets(BuildContext context, String status) async {
    isFetchingBets(true);

    final Either<Failure, List<Bet>> failureOrBets = await fetchStatusBets(
      StatusBetsRequests(status: status),
    );

    failureOrBets.fold<void>(
      (Failure failure) {
        isFetchingBets(false);
      },
      (List<Bet> value) {
        isFetchingBets(false);
        bets(value);
      },
    );
  }

  void changeFilterStatus(String status) {
    filterStatus.value = status;
    getMyBets(status);
  }

  void getMyBets(String status) async {
    isFetchingMyBets(true);

    final Either<Failure, List<Bet>> failureOrBets =
        await fetchMyBets(StatusBetsRequests(status: status));

    failureOrBets.fold<void>(
      (Failure failure) {
        isFetchingMyBets(false);
      },
      (List<Bet> value) {
        isFetchingMyBets(false);
        myBets.value = value;
      },
    );
  }

  void getMyTransactions() async {
    isFetchingTransactions(true);

    final Either<Failure, List<Transaction>> failureOrTransactions =
        await getUserTransactions(
            UserRequest(userId: bController.user.value.id));

    failureOrTransactions.fold<void>(
      (Failure failure) {
        isFetchingTransactions(false);
      },
      (List<Transaction> value) {
        isFetchingTransactions(false);
        myTransactions.value = value;
      },
    );
  }

  List<Transaction> getBetTransactions(bool? isSale) => myTransactions
      .where((Transaction trans) => trans.description
          .toLowerCase()
          .contains(isSale == true ? 'xviral' : 'bet'))
      .toList();
}
