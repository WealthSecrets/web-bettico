import 'package:betticos/features/okx_swap/domain/usecases/convert_trade.dart';
import 'package:betticos/features/okx_swap/domain/usecases/create_deposit_address.dart';
import 'package:betticos/features/okx_swap/domain/usecases/estimate_conversion_quote.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_conversion_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_currency_pair.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_deposit_history.dart';
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
        ),
        createDepositAddress: CreateDepositAddress(
          okxRepository: Get.find(),
        ),
        fetchDepositHistory: FetchDepositHistory(
          okxRepository: Get.find(),
        ),
        fetchConversionHistory: FetchConversionHistory(
          okxRepository: Get.find(),
        ),
        convertTrade: ConvertTrade(
          okxRepository: Get.find(),
        ),
        estimateConversionQuote: EstimateConversionQuote(
          okxRepository: Get.find(),
        ),
        fetchCurrencyPair: FetchCurrencyPair(
          okxRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
