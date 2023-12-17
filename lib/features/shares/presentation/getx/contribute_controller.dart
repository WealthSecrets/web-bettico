import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContributeController extends GetxController {
  RxBool isCreatingSale = false.obs;
  RxString contributionAmount = ''.obs;
  RxString amountDisplay = ''.obs;
  RxString shares = ''.obs;
  RxString withdrawShares = ''.obs;
  RxString subscriptions = ''.obs;
  RxString withdrawalAmount = ''.obs;
  RxString withdrawalAmountDisplay = ''.obs;
  RxBool isLoading = false.obs;

  final WalletController walletController = Get.find<WalletController>();

  void contribute(String saleId, {VoidCallback? callback}) async {
    walletController.contribute(saleId, shares.value, contributionAmount.value, callback: callback);
  }

  void purchase(String saleId, {VoidCallback? callback}) async {
    walletController.purchase(saleId, shares.value, contributionAmount.value, callback: callback);
  }

  void withdraw(String saleId, {VoidCallback? callback}) async {
    walletController.withdraw(saleId, withdrawShares.value, callback: callback);
  }

  void withdrawBalance({VoidCallback? callback}) async {
    walletController.withdrawBalance(withdrawalAmount.value, callback: callback);
  }

  void onAmountChanged(double amount, BuildContext context) {
    isLoading.value = true;
    walletController.convertAmount(
      context,
      'eth',
      amount,
      successCallback: (double amount) {
        final double fAmount = amount * weiMultiplier;
        contributionAmount('${fAmount.toInt()}');
        amountDisplay(amount.toStringAsFixed(6));
        isLoading.value = false;
      },
    );
  }

  void onWithdrawalAmountChanged(double amount, BuildContext context) {
    isLoading.value = true;
    walletController.convertAmount(
      context,
      'eth',
      amount,
      successCallback: (double amount) {
        final double fAmount = amount * weiMultiplier;
        withdrawalAmount('${fAmount.toInt()}');
        withdrawalAmountDisplay(amount.toStringAsFixed(6));
        isLoading.value = false;
      },
    );
  }

  void onSharesChanged(String value) {
    shares(value.trim());
  }

  void onWithdrawSharesChanged(String value) {
    withdrawShares(value.trim());
  }

  void onSubscriptionsChanged(String value) {
    subscriptions(value.trim());
  }

  String? validateAmount(String value) {
    final double? amount = double.tryParse(value);
    String? errorMessage;
    if (amount == null) {
      errorMessage = 'Enter amount';
    }
    if (amount != null && amount <= 0) {
      errorMessage = 'Invalid amount';
    }

    return errorMessage;
  }

  String? validateWithdrawalAmount(String value) {
    final double? amount = double.tryParse(value);
    String? errorMessage;
    if (amount == null) {
      errorMessage = 'Enter amount';
    }
    if (amount != null && amount <= 0) {
      errorMessage = 'Invalid amount';
    }

    return errorMessage;
  }

  String? validateShares(String value) {
    String? errorMessage;
    final int? shares = int.tryParse(value);
    if (value.isEmpty) {
      errorMessage = 'Enter number of shares';
    }
    if (shares != null && shares <= 0) {
      errorMessage = 'Invalid shares value';
    }
    return errorMessage;
  }

  String? validateWithdrawShares(String? value, int shares) {
    String? message;
    final int? vShares = int.tryParse('$value');
    if (vShares == null) {
      message = 'Invalid share value';
    }
    if (vShares != null && vShares <= 0) {
      message = 'Cannot withdraw zero shares';
    }
    if (vShares != null && vShares > shares) {
      message = 'Cannot withdraw more than available shares';
    }
    return message;
  }

  String? validateSubscriptoins(String value) {
    String? errorMessage;
    final int? subscriptions = int.tryParse(value);
    if (subscriptions != null && subscriptions <= 0) {
      errorMessage = 'Invalid subscription value';
    }
    return errorMessage;
  }

  bool get formIsValid =>
      contributionAmount.value.isNotEmpty &&
      validateShares(shares.value) == null &&
      validateSubscriptoins(subscriptions.value) == null;

  bool withdrawFormIsValid(int shares) => validateWithdrawShares(withdrawShares.value, shares) == null;

  bool get withdrawalFormIsValid => validateWithdrawalAmount(withdrawalAmount.value) == null;
}
