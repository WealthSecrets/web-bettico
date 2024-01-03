import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'withdrawal_controller.dart';

class WithdrawalBindings {
  static void dependencies() {
    Get.lazyPut(
      () => WithdrawalController(
        fetchWithdrawalHistory: FetchWithdrawalHistory(okxRepository: Get.find()),
        withdraw: Withdraw(okxRepository: Get.find()),
      ),
    );
  }
}
