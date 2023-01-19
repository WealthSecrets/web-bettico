import 'package:betticos/features/okx_swap/domain/usecases/get_asset_currencies.dart';
import 'package:betticos/features/okx_swap/domain/usecases/get_convert_currencies.dart';
import 'package:betticos/features/okx_swap/domain/usecases/get_okx_account.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:get/get.dart';

class OkxBindigns {
  static void dependencies() {
    Get.put<OkxController>(
      OkxController(
          getAssetCurrencies: GetAssetCurrencies(
            okxRepository: Get.find(),
          ),
          getConvertCurrencies: GetConvertCurrencies(
            okxRepository: Get.find(),
          ),
          getOkxAccount: GetOkxAccount(
            okxRepository: Get.find(),
          )),
      permanent: true,
    );
  }
}
