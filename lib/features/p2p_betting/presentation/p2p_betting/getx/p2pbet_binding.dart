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
import 'package:get/get.dart';

import '/features/p2p_betting/domain/usecases/bet/fetch_bets.dart';
import '/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import '../../../domain/usecases/bet/add_bet.dart';

class P2PBetBindings {
  static void dependencies() {
    Get.put(
      P2PBetController(
        searchBets: SearchBets(
          p2pRepository: Get.find(),
        ),
        addBet: AddBet(
          p2prepository: Get.find(),
        ),
        addTransaction: AddTransaction(
          p2prepository: Get.find(),
        ),
        fetchBets: FetchBets(
          p2pRepository: Get.find(),
        ),
        getCompetitionMatch: GetCompetitionMatch(
          p2pRepository: Get.find(),
        ),
        getTeamMatch: GetTeamMatch(
          p2pRepository: Get.find(),
        ),
        fetchStatusBets: FetchStatusBets(
          p2pRepository: Get.find(),
        ),
        updateBet: UpdateBet(
          p2prepository: Get.find(),
        ),
        updateBetStatusScore: UpdateBetStatusScore(
          p2prepository: Get.find(),
        ),
        getFixture: GetFixture(
          p2pRepository: Get.find(),
        ),
        fetchMyBets: FetchMyBets(
          p2pRepository: Get.find(),
        ),
        updateBetPayoutStatus: UpdateBetPayoutStatus(
          p2prepository: Get.find(),
        ),
        updateTransaction: UpdateTransaction(
          p2prepository: Get.find(),
        ),
        getUserTransactions: GetUserTransactions(
          p2prepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
