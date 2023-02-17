import 'package:betticos/features/okx_swap/domain/usecases/fetch_withdrawal_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/withdraw.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/getx/withdrawal_controller.dart';
import 'package:get/get.dart';

class WithdrawalBindings {
  static void dependencies() {
    Get.lazyPut(
      () => WithdrawalController(
        fetchWithdrawalHistory: FetchWithdrawalHistory(
          okxRepository: Get.find(),
        ),
        withdraw: Withdraw(
          okxRepository: Get.find(),
        ),
      ),
    );
  }
}
