import 'dart:convert';

import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

class UsdtSaleController extends GetxController {
  UsdtSaleController();

  RxString fiatAmount = ''.obs;
  RxString walletAddress = ''.obs;
  RxDouble price = 12.11.obs;
  RxDouble quantity = 0.0.obs;

  RxBool isTransferringFunds = false.obs;

  Future<TransactionResponse?> transferUSDT(BuildContext context) async {
    isTransferringFunds.value = true;
    final double amount = quantity.value * 1000000000 * 1000000000;
    final String jsonText = await rootBundle.loadString('assets/keys/keys.json');

    final dynamic value = json.decode(jsonText);

    final String tokenAddress = value['usdt'] as String;
    final String mnemonic = value['phrase'] as String;

    final Wallet wallet = Wallet.fromMnemonic(mnemonic);

    final JsonRpcProvider jsonRpcProvider = JsonRpcProvider('https://bsc-dataseed.binance.org/');

    final Wallet walletProvider = wallet.connect(jsonRpcProvider);

    final ContractERC20 token = ContractERC20(tokenAddress, walletProvider);

    try {
      final TransactionResponse response = await token.transfer(
        walletAddress.value,
        BigInt.from(amount.round()),
      );
      isTransferringFunds.value = false;
      return response;
    } catch (e) {
      isTransferringFunds.value = false;
      if (context.mounted) {
        await AppSnacks.show(
          context,
          message: 'Sorry, failed to send you USDT to your wallet address.',
        );
      }
      return null;
    }
  }

  void onAmountInputChanged(String value) {
    fiatAmount(value);
    final double? amount = double.tryParse(value);
    if (amount != null) {
      quantity.value = amount / price.value;
    } else {
      quantity.value = 0.0;
    }
  }

  void onWalletAddressChanged(String value) {
    walletAddress(value);
  }

  String? validateAmount(String stringAmount) {
    final double? amount = double.tryParse(stringAmount);
    if (amount == null) {
      return 'Invalid amount';
    }
    if (amount < 1) {
      return r'Minimum of $1';
    }
    if (amount > 1000) {
      return r'Maximum of $10,000';
    }
    return null;
  }

  String? validateAddress(String? address) {
    String? errorMessage;
    if (address!.isEmpty) {
      errorMessage = 'Please enter wallet address';
    }
    return errorMessage;
  }

  void reset() {
    fiatAmount.value = '';
    walletAddress.value = '';
    quantity.value = 0.0;
  }

  bool get formIsValid => validateAmount(fiatAmount.value) == null && validateAddress(walletAddress.value) == null;
}
