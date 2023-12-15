import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/crypto/convert_amount_to_currency.dart';
import 'package:get/get.dart';

class WalletBindings {
  static void dependencies() {
    Get.put(
      WalletController(
        convertAmountToCurrency: ConvertAmountToCurrency(p2pRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
