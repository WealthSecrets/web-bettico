import 'package:betticos/features/okx_swap/domain/usecases/fetch_transfer_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/subaccount_fund_transfer.dart';
import 'package:betticos/features/okx_swap/presentation/funds/getx/funds_controller.dart';
import 'package:get/get.dart';

class FundsBindings {
  static void dependencies() {
    Get.lazyPut(
      () => FundsController(
        subAccountFundTransfer: SubAccountFundTransfer(
          okxRepository: Get.find(),
        ),
        fetchTransferHistory: FetchTransferHistory(
          okxRepository: Get.find(),
        ),
      ),
    );
  }
}
