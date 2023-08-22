import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';
import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';
import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:betticos/features/okx_swap/domain/requests/bank/bank_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/recipient/recipient_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/resolve_account/resolve_account_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/transfer_request.dart';
import 'package:betticos/features/okx_swap/domain/usecases/create_recipient.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_banks_telcos.dart';
import 'package:betticos/features/okx_swap/domain/usecases/initiate_transfer.dart';
import 'package:betticos/features/okx_swap/domain/usecases/resolve_account.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SellMethod { bank, momo }

class SellUsdtController extends GetxController {
  SellUsdtController({
    required this.fetchBanksTelcos,
    required this.resolveAccount,
    required this.createRecipient,
    required this.initiateTransfer,
  });

  final FetchBanksTelcos fetchBanksTelcos;
  final ResolveAccount resolveAccount;
  final CreateRecipient createRecipient;
  final InitiateTransfer initiateTransfer;

  final String message = 'invalid number';
  RxString usdtAmount = ''.obs;
  RxDouble referencePrice = 11.65.obs;
  RxDouble quantity = 0.0.obs;
  RxBool isTransferringFunds = false.obs;
  RxBool isFetchingBanksTelcos = false.obs;
  RxBool isResolvingAccount = false.obs;
  RxBool isCreateingRecipient = false.obs;
  RxBool isInitiatingTransfer = false.obs;
  RxString currency = 'GHS'.obs;
  RxString accountNumber = ''.obs;
  RxList<Bank> banksTelcos = <Bank>[].obs;
  Rx<Bank> selectedBank = Bank.empty().obs;
  RxString resolvedName = ''.obs;
  Rx<Recipient> recipient = Recipient.empty().obs;
  Rx<Transfer> transfer = Transfer.empty().obs;

  Rx<SellMethod> sellMethod = SellMethod.bank.obs;
  Rx<TextEditingController> textEditingController = TextEditingController(text: '').obs;

  void onAmountInputChanged(String value) {
    usdtAmount(value);
    final double? amount = double.tryParse(value);
    if (amount != null) {
      quantity.value = amount * referencePrice.value;
    } else {
      quantity.value = 0.0;
    }
  }

  void onAccountNumberInputChanged(String value) {
    accountNumber(value);
  }

  String? validateAmount(String stringAmount) {
    final double? amount = double.tryParse(stringAmount);
    if (amount == null) {
      return 'Invalid amount';
    }
    if (amount < 10) {
      return r'Minimum of $10';
    }
    if (amount > 10000) {
      return r'Maximum of $10,000';
    }
    return null;
  }

  String? validateAccountNumber(String accNum) {
    String? errorMesage;
    if (accNum.isEmpty) {
      errorMesage = '${sellMethod.value == SellMethod.bank ? 'Bank account' : 'Phone'} number is required';
    }
    return errorMesage;
  }

  bool get formIsValid =>
      validateAmount(usdtAmount.value) == null &&
      accountNumber.value.isNotEmpty &&
      selectedBank.value.name.isNotEmpty &&
      resolvedName.value.isNotEmpty &&
      resolvedName.value != message;

  void fetchBanksOrTelcos(BuildContext context) async {
    isFetchingBanksTelcos(true);

    final Either<Failure, List<Bank>> failureOrCurrencies = await fetchBanksTelcos(
      BankRequest(
        currency: currency.value,
        type: sellMethod.value == SellMethod.momo ? 'mobile_money' : null,
      ),
    );

    failureOrCurrencies.fold<void>(
      (Failure failure) {
        isFetchingBanksTelcos(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<Bank> value) {
        isFetchingBanksTelcos(false);
        banksTelcos.value = value;
      },
    );
  }

  void resolverAccountNumber(BuildContext context, {String? accNumber, String? bankCode}) async {
    final String number = accNumber ?? accountNumber.value;
    final String code = bankCode ?? selectedBank.value.code;

    if (number.isNotEmpty && code.isNotEmpty) {
      isResolvingAccount(true);
      final Either<Failure, ResolveResponse> failureOrCurrencies = await resolveAccount(
        ResolveAccountRequest(
          accoutNumber: accNumber ?? accountNumber.value,
          bankCode: bankCode ?? selectedBank.value.code,
        ),
      );
      failureOrCurrencies.fold<void>(
        (Failure failure) {
          isResolvingAccount(false);
          resolvedName.value = message;
        },
        (ResolveResponse response) {
          isResolvingAccount(false);
          resolvedName.value = response.accountName;
        },
      );
    }
  }

  void createTransferRecipient(BuildContext context, {String? accNumber, String? bankCode}) async {
    final String number = accNumber ?? accountNumber.value;
    final String code = bankCode ?? selectedBank.value.code;

    if (number.isNotEmpty && code.isNotEmpty) {
      isCreateingRecipient(true);

      final Either<Failure, Recipient> failureOrCurrencies = await createRecipient(
        RecipientRequest(
          type: 'basa',
          name: resolvedName.value,
          accountNumber: number,
          bankCode: code,
          currency: 'GHS',
          usdAmount: double.parse(usdtAmount.value),
          amount: quantity.value,
          destination: sellMethod.value.name,
        ),
      );

      failureOrCurrencies.fold<void>(
        (Failure failure) {
          isCreateingRecipient(false);
          AppSnacks.show(context, message: failure.message);
        },
        (Recipient response) {
          isCreateingRecipient(false);
          recipient.value = response;
          Navigator.of(context).pushReplacementNamed(AppRoutes.sellUsdtSummary);
        },
      );
    }
  }

  void initTransfer(BuildContext context, {String? accNumber, String? bankCode}) async {
    final String number = accNumber ?? accountNumber.value;
    final String code = bankCode ?? selectedBank.value.code;

    if (number.isNotEmpty && code.isNotEmpty) {
      isInitiatingTransfer(true);
      final Either<Failure, Transfer> failureOrCurrencies = await initiateTransfer(
        TransferRequest(
          accountNumber: accountNumber.value,
          amount: quantity.value * 100,
          recipientCode: recipient.value.recipientCode,
          source: 'balance',
        ),
      );
      failureOrCurrencies.fold<void>(
        (Failure failure) {
          isInitiatingTransfer(false);
          AppSnacks.show(context, message: failure.message);
        },
        (Transfer response) {
          isInitiatingTransfer(false);
          transfer.value = response;
        },
      );
    }
  }

  void resetValues() {
    recipient.value = Recipient.empty();
    transfer.value = Transfer.empty();
    usdtAmount.value = '';
    quantity.value = 0.0;
    currency.value = 'GHS';
    accountNumber.value = '';
    selectedBank.value = Bank.empty();
    resolvedName = ''.obs;
  }
}
