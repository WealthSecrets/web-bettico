import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'funds_controller.dart';

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
