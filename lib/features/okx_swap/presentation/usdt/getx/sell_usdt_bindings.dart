import 'package:betticos/features/okx_swap/domain/usecases/create_recipient.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_banks_telcos.dart';
import 'package:betticos/features/okx_swap/domain/usecases/initiate_transfer.dart';
import 'package:betticos/features/okx_swap/domain/usecases/resolve_account.dart';
import 'package:get/get.dart';

import 'sell_usdt_controller.dart';

class SellUsdtBindings {
  static void dependencies() {
    Get.put<SellUsdtController>(
      SellUsdtController(
        fetchBanksTelcos: FetchBanksTelcos(paystackRepository: Get.find()),
        resolveAccount: ResolveAccount(paystackRepository: Get.find()),
        createRecipient: CreateRecipient(paystackRepository: Get.find()),
        initiateTransfer: InitiateTransfer(paystackRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
