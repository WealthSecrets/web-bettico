import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:betticos/features/okx_swap/domain/usecases/create_deposit_address.dart';
import 'package:betticos/features/okx_swap/domain/usecases/get_asset_currencies.dart';
import 'package:betticos/features/okx_swap/domain/usecases/get_convert_currencies.dart';
import 'package:betticos/features/okx_swap/domain/usecases/get_okx_account.dart';
import 'package:betticos/features/okx_swap/presentation/address/address_details_screen.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class OkxController extends GetxController {
  OkxController({
    required this.getAssetCurrencies,
    required this.getConvertCurrencies,
    required this.getOkxAccount,
    required this.createDepositAddress,
  });

  //
  final GetAssetCurrencies getAssetCurrencies;
  final GetConvertCurrencies getConvertCurrencies;
  final GetOkxAccount getOkxAccount;
  final CreateDepositAddress createDepositAddress;

  final Rx<Currency> fromCurrency = Currency.mock().obs;
  Rx<Currency> toCurrency = Currency.mock().obs;
  RxList<Currency> assetCurrencies = <Currency>[].obs;
  RxList<Currency> convertCurrencies = <Currency>[].obs;
  RxList<Currency> options = <Currency>[].obs;
  RxString selectedChain = ''.obs;
  Rx<OkxAccount> myOkxAccount = OkxAccount.empty().obs;
  RxDouble amount = 0.0.obs;

  // loading state
  RxBool isFetchingAssetCurrencies = false.obs;
  RxBool isFetchingConvertCurrencies = false.obs;
  RxBool isGettingOkxAccount = false.obs;
  RxBool isCreatingDepositAddress = false.obs;
  RxBool isFilterred = false.obs;

  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();

  void fetchAssetCurrencies(BuildContext context) async {
    isFetchingAssetCurrencies(true);

    final Either<Failure, List<Currency>> failureOrCurrencies =
        await getAssetCurrencies(NoParams());

    failureOrCurrencies.fold<void>(
      (Failure failure) {
        isFetchingAssetCurrencies(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Currency> value) {
        isFetchingAssetCurrencies(false);
        assetCurrencies.value = value;
      },
    );
  }

  void createOkxDepositAddress(
      BuildContext context, String currency, String chain) async {
    isCreatingDepositAddress(true);
    selectedChain.value = chain;

    final Either<Failure, CreateDepositAddressResponse> failureOrOkxAccount =
        await createDepositAddress(
            CreateDepositAddressRequest(currency: currency, chain: chain));

    failureOrOkxAccount.fold(
      (Failure failure) {
        isCreatingDepositAddress(false);
        AppSnacks.show(context, message: failure.message);
      },
      (CreateDepositAddressResponse response) {
        isCreatingDepositAddress(false);
        baseScreenController.user.value = response.account.user;
        navigationController.navigateTo(
          AppRoutes.addressDetails,
          arguments:
              AddressDetailsScreenRouteArgument(address: response.address),
        );
      },
    );
  }

  void setSelectedCurrency(String chain) {
    selectedChain.value = chain;
  }

  void fetchConvertCurrencies(BuildContext context) async {
    isFetchingConvertCurrencies(true);

    final Either<Failure, List<Currency>> failureOrCurrencies =
        await getConvertCurrencies(NoParams());

    failureOrCurrencies.fold<void>(
      (Failure failure) {
        isFetchingConvertCurrencies(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Currency> value) {
        isFetchingConvertCurrencies(false);
        convertCurrencies.value = value;
      },
    );
  }

  void getUserOkxAccount(BuildContext context) async {
    isGettingOkxAccount(true);

    final Either<Failure, OkxAccount> failureOrAccount =
        await getOkxAccount(NoParams());

    failureOrAccount.fold<void>(
      (Failure failure) {
        isGettingOkxAccount(false);
        AppSnacks.show(context, message: failure.message);
      },
      (OkxAccount account) {
        isGettingOkxAccount(false);
        myOkxAccount.value = account;
      },
    );
  }

  bool get doneLoading =>
      !isFetchingAssetCurrencies.value && !isFetchingConvertCurrencies.value;

  void filterCurrencies() {
    if (doneLoading &&
        convertCurrencies.isNotEmpty &&
        assetCurrencies.isNotEmpty) {
      final List<Currency> tempOptions = <Currency>[];
      for (int i = 0; i < convertCurrencies.length; i++) {
        for (int j = 0; j < assetCurrencies.length; j++) {
          if (convertCurrencies[i].currency.toLowerCase() ==
                  assetCurrencies[i].currency.toLowerCase() &&
              !currenciesContain(
                tempOptions,
                assetCurrencies[i].currency,
              )) {
            tempOptions.add(assetCurrencies[i]);
            break;
          }
        }
      }
      options(tempOptions);
      fromCurrency.value = tempOptions.first;
      toCurrency.value = tempOptions.last;
      isFilterred.value = true;
    }
  }

  List<Currency> getTokens(String ccy) {
    return assetCurrencies
        .where((Currency currency) => currency.currency == ccy)
        .toList();
  }

  bool currenciesContain(List<Currency> currencies, String ccy) {
    final Currency? ccyNull = currencies.firstWhereOrNull((Currency currency) =>
        currency.currency.toLowerCase() == ccy.toLowerCase());
    if (ccyNull == null) {
      return false;
    }
    return true;
  }

  void onAmountChanged(String? value) {
    if (value != null && value.isNotEmpty) {
      final double amt = double.parse(value);
      amount.value = amt;
    }
  }

  void swapCurrencies() {
    final Currency tempCurrency = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = tempCurrency;
  }
}
