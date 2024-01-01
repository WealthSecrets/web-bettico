import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:get/get.dart';

class P2PBetBindings {
  static void dependencies() {
    Get.put(
      P2PBetController(
        searchBets: SearchBets(p2pRepository: Get.find()),
        addBet: AddBet(p2prepository: Get.find()),
        addTransaction: AddTransaction(p2prepository: Get.find()),
        fetchBets: FetchBets(p2pRepository: Get.find()),
        fetchStatusBets: FetchStatusBets(p2pRepository: Get.find()),
        updateBet: UpdateBet(p2prepository: Get.find()),
        updateBetStatusScore: UpdateBetStatusScore(p2prepository: Get.find()),
        fetchMyBets: FetchMyBets(p2pRepository: Get.find()),
        updateBetPayoutStatus: UpdateBetPayoutStatus(p2prepository: Get.find()),
        updateTransaction: UpdateTransaction(p2prepository: Get.find()),
        getUserTransactions: GetUserTransactions(p2prepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
