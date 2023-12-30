import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'okx_controller.dart';

class OkxBindigns {
  static void dependencies() {
    Get.put<OkxController>(
      OkxController(
        getAssetCurrencies: GetAssetCurrencies(okxRepository: Get.find()),
        getConvertCurrencies: GetConvertCurrencies(okxRepository: Get.find()),
        getOkxAccount: GetOkxAccount(okxRepository: Get.find()),
        createDepositAddress: CreateDepositAddress(okxRepository: Get.find()),
        fetchDepositHistory: FetchDepositHistory(okxRepository: Get.find()),
        fetchConversionHistory: FetchConversionHistory(okxRepository: Get.find()),
        convertTrade: ConvertTrade(okxRepository: Get.find()),
        estimateConversionQuote: EstimateConversionQuote(okxRepository: Get.find()),
        fetchCurrencyPair: FetchCurrencyPair(okxRepository: Get.find()),
        fetchBalances: FetchBalances(okxRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
