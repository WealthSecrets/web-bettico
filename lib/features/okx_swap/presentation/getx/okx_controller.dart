import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_conversion.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency_pair.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/conversion_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/currency_pair_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/quote_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:betticos/features/okx_swap/domain/usecases/convert_trade.dart';
import 'package:betticos/features/okx_swap/domain/usecases/create_deposit_address.dart';
import 'package:betticos/features/okx_swap/domain/usecases/estimate_conversion_quote.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_balances.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_conversion_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_currency_pair.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_deposit_history.dart';
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
    required this.fetchDepositHistory,
    required this.fetchConversionHistory,
    required this.convertTrade,
    required this.estimateConversionQuote,
    required this.fetchCurrencyPair,
    required this.fetchBalances,
  });

  //
  final GetAssetCurrencies getAssetCurrencies;
  final GetConvertCurrencies getConvertCurrencies;
  final GetOkxAccount getOkxAccount;
  final CreateDepositAddress createDepositAddress;
  final FetchDepositHistory fetchDepositHistory;
  final FetchConversionHistory fetchConversionHistory;
  final ConvertTrade convertTrade;
  final EstimateConversionQuote estimateConversionQuote;
  final FetchCurrencyPair fetchCurrencyPair;
  final FetchBalances fetchBalances;

  Rx<Currency> fromCurrency = Currency.mock().obs;
  Rx<Currency> toCurrency = Currency.mock().obs;
  Rx<Currency> selectedCurrency = Currency.mock().obs;
  RxString quoteAmount = ''.obs;
  RxString fromCurrencyAmount = '0'.obs;
  RxString toCurrencyAmount = '0'.obs;
  RxString fromCurrencyHint = ''.obs;
  RxString toCurrencyHint = ''.obs;
  RxString topTitle = 'From'.obs;
  RxString bottomTitle = 'To'.obs;
  Rx<CurrencyPair> currentCurrencyPair = CurrencyPair.mock().obs;
  Rx<OkxQuote> currentQuote = OkxQuote.empty().obs;
  Rx<ConversionResponse> currentConversion = ConversionResponse.empty().obs;
  RxList<Currency> assetCurrencies = <Currency>[].obs;
  RxList<Deposit> deposits = <Deposit>[].obs;
  RxList<OkxConversion> conversions = <OkxConversion>[].obs;
  RxList<Currency> convertCurrencies = <Currency>[].obs;
  RxList<Currency> options = <Currency>[].obs;
  RxList<BalanceResponse> myBalances = <BalanceResponse>[].obs;
  RxString selectedChain = ''.obs;
  Rx<OkxAccount> myOkxAccount = OkxAccount.empty().obs;
  RxDouble amount = 0.0.obs;
  RxString isSwap = '0'.obs;

  RxString keyword = ''.obs;
  RxList<Currency> searchCurrencies = <Currency>[].obs;

  // loading state
  RxBool isFetchingAssetCurrencies = false.obs;
  RxBool isFetchingDepositHistory = false.obs;
  RxBool isFetchingBalances = false.obs;
  RxBool isFetchingCurrencyPair = false.obs;
  RxBool isEstimatingConversion = false.obs;
  RxBool isConvertingCrypto = false.obs;
  RxBool isFetchingConvertCurrencies = false.obs;
  RxBool isGettingOkxAccount = false.obs;
  RxBool isCreatingDepositAddress = false.obs;
  RxBool isFilterred = false.obs;
  RxBool isFetchingConversionHistory = false.obs;

  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    fromController.dispose();
    toController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    resetSearch();
  }

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

  bool get isConvertScreenLoading =>
      isFetchingAssetCurrencies.value ||
      isFetchingConvertCurrencies.value ||
      isFetchingCurrencyPair.value;

  void getDepositHistory(BuildContext context) async {
    isFetchingDepositHistory(true);

    final Either<Failure, List<Deposit>> failureOrDeposits =
        await fetchDepositHistory(NoParams());

    failureOrDeposits.fold<void>(
      (Failure failure) {
        isFetchingDepositHistory(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Deposit> value) {
        isFetchingDepositHistory(false);
        deposits.value = value;
      },
    );
  }

  void getConversionHistory(BuildContext context) async {
    isFetchingConversionHistory(true);

    final Either<Failure, List<OkxConversion>> failureOrConversion =
        await fetchConversionHistory(NoParams());

    failureOrConversion.fold<void>(
      (Failure failure) {
        isFetchingConversionHistory(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<OkxConversion> value) {
        isFetchingConversionHistory(false);
        conversions.value = value;
      },
    );
  }

  void getBalances(BuildContext context) async {
    isFetchingBalances(true);

    final Either<Failure, List<BalanceResponse>> failureOrResponse =
        await fetchBalances(NoParams());

    failureOrResponse.fold<void>(
      (Failure failure) {
        isFetchingBalances(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<BalanceResponse> value) {
        isFetchingBalances(false);
        myBalances.value = value;
      },
    );
  }

  BalanceResponse? getCurrencyBalance(String ccy) =>
      myBalances.firstWhereOrNull((BalanceResponse el) =>
          el.currency.toLowerCase() == ccy.toLowerCase());

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

  void getCurrencyPair(BuildContext context) async {
    isFetchingCurrencyPair(true);

    final Either<Failure, CurrencyPair> failureOrCurrencyPair =
        await fetchCurrencyPair(
      CurrencyPairRequest(
        fromCurrency: fromCurrency.value.currency,
        toCurrency: toCurrency.value.currency,
      ),
    );

    failureOrCurrencyPair.fold<void>(
      (Failure failure) {
        isFetchingCurrencyPair(false);
        AppSnacks.show(context, message: failure.message);
      },
      (CurrencyPair currencyPair) {
        isFetchingCurrencyPair(false);
        currentCurrencyPair.value = currencyPair;

        setFromCurrencyHint();
        setToCurrencyHint();
      },
    );
  }

  void setToCurrencyHint() {
    toCurrencyHint.value =
        '${currentCurrencyPair.value.baseCurrencyMinimumAmount} - ${currentCurrencyPair.value.baseCurrencyMaximumAmount}';
  }

  void setFromCurrencyHint() {
    fromCurrencyHint.value =
        '${currentCurrencyPair.value.quoteCurrencyMinimumAmount} - ${currentCurrencyPair.value.quoteCurrencyMaximumAmount}';
  }

  void getConversionQuote(BuildContext context, [Function()? callback]) async {
    isEstimatingConversion(true);

    final Either<Failure, OkxQuote> failureOrQuote =
        await estimateConversionQuote(
      QuoteRequest(
        baseCurrency: currentCurrencyPair.value.baseCurrency,
        quoteCurrency: currentCurrencyPair.value.quoteCurrency,
        realAmount: quoteAmount.value,
        realAmountCurrency: selectedCurrency.value.currency,
        side: getSide(currentCurrencyPair.value.baseCurrency),
      ),
    );

    failureOrQuote.fold<void>(
      (Failure failure) {
        isEstimatingConversion(false);
        AppSnacks.show(context, message: failure.message);
      },
      (OkxQuote quote) {
        isEstimatingConversion(false);
        currentQuote.value = quote;
        callback?.call();
      },
    );
  }

  String getSide(String baseCurrency) =>
      baseCurrency.toUpperCase() == fromCurrency.value.currency.toUpperCase()
          ? 'sell'
          : 'buy';

  void convertCrypto(BuildContext context) async {
    isConvertingCrypto(true);

    final Either<Failure, ConversionResponse> failureOrConversionResponse =
        await convertTrade(
      ConversionRequest(
        baseCurrency: currentQuote.value.baseCurrency,
        quoteCurrency: currentQuote.value.quoteCurrency,
        realAmount: quoteAmount.value,
        realAmountCurrency: selectedCurrency.value.currency,
        side: getSide(currentQuote.value.baseCurrency),
        quoteId: currentQuote.value.quoteId,
        clientOrderId: currentQuote.value.clientOrderId,
      ),
    );

    failureOrConversionResponse.fold<void>(
      (Failure failure) {
        isConvertingCrypto(false);
        AppSnacks.show(context, message: failure.message);
      },
      (ConversionResponse response) {
        isConvertingCrypto(false);
        currentConversion.value = response;
        Navigator.of(context).pop();
        navigationController.navigateTo(AppRoutes.conversionSuccess);
      },
    );
  }

  bool get doneLoading =>
      !isFetchingAssetCurrencies.value && !isFetchingConvertCurrencies.value;

  void filterCurrencies(BuildContext context) {
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
      getCurrencyPair(context);
    }
  }

  void searchCurrencyOptions(String value) {
    if (value.isEmpty) {
      resetSearch();
    } else {
      keyword(value);
      final List<Currency> values = options
          .where((Currency p0) =>
              p0.currency.toLowerCase().contains(keyword.value.toLowerCase()) ||
              p0.chain != null &&
                  p0.chain!.toLowerCase().contains(keyword.value.toLowerCase()))
          .toList();
      searchCurrencies(values);
    }
  }

  void resetSearch() {
    keyword('');
    searchCurrencies(<Currency>[]);
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

  void onFromCurrencyInputChanged(String value) {
    final double? amount = double.tryParse(value);
    if (amount == null) {
      setToCurrencyHint();
      quoteAmount.value = '';
    } else {
      quoteAmount.value = value;
      toCurrencyHint.value = '--';
      toController.text = '';
      fromCurrencyAmount.value = value;
      selectedCurrency.value = fromCurrency.value;
    }
  }

  void onToCurrencyInputChanged(String value) {
    final double? amount = double.tryParse(value);
    if (amount == null) {
      setFromCurrencyHint();
      quoteAmount.value = '';
    } else {
      quoteAmount.value = value;
      fromCurrencyHint.value = '--';
      fromController.text = '';
      toCurrencyAmount.value = value;
      selectedCurrency.value = toCurrency.value;
    }
  }

  String? onToCurrencyValidator(String amountInString) {
    final double? amount = double.tryParse(amountInString);

    final double minimumAmount =
        double.parse(currentCurrencyPair.value.baseCurrencyMinimumAmount);

    final double maxAmount =
        double.parse(currentCurrencyPair.value.baseCurrencyMaximumAmount);
    final String currency = currentCurrencyPair.value.baseCurrency;

    if (amount != null && amount < minimumAmount) {
      return 'Minimum of $minimumAmount $currency'.trim();
    }
    if (amount != null && amount > maxAmount) {
      return 'Maximum of $maxAmount $currency'.trim();
    }
    return null;
  }

  String? onFromCurrencyValidator(String amountInString) {
    final double? amount = double.tryParse(amountInString);

    final double minimumAmount =
        double.parse(currentCurrencyPair.value.quoteCurrencyMinimumAmount);

    final double maxAmount =
        double.parse(currentCurrencyPair.value.quoteCurrencyMaximumAmount);

    final String currency = currentCurrencyPair.value.quoteCurrency;

    if (amount != null && amount < minimumAmount) {
      return 'Minimum of $minimumAmount $currency'.trim();
    }
    if (amount != null && amount > maxAmount) {
      return 'Maximum of $maxAmount $currency'.trim();
    }
    return null;
  }

  Currency? getCurrency(String chain) => assetCurrencies
      .firstWhereOrNull((Currency currency) => currency.chain == chain);

  Currency? getCurrencyByCurrency(String ccy) => assetCurrencies
      .firstWhereOrNull((Currency currency) => currency.currency == ccy);

  void swapCurrencies(BuildContext context) {
    if (isSwap.value == '-1') {
      isSwap.value = '0';
    } else {
      isSwap.value = '-1';
    }
    final Currency tempCurrency = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = tempCurrency;
    final String tempCurrencyHint = fromCurrencyHint.value;
    fromCurrencyHint.value = toCurrencyHint.value;
    toCurrencyHint.value = tempCurrencyHint;
    final String tempTitle = topTitle.value;
    topTitle.value = bottomTitle.value;
    bottomTitle.value = tempTitle;
    final String fromText = fromController.text;
    if (fromText.isNotEmpty) {
      fromController.text = quoteAmount.toString();
      toController.text = '';
      selectedCurrency.value = fromCurrency.value;
    } else {
      toController.text = quoteAmount.toString();
      fromController.text = '';
      selectedCurrency.value = toCurrency.value;
    }
    getCurrencyPair(context);
  }
}
