import 'package:get/get.dart';

class UsdtSaleController extends GetxController {
  UsdtSaleController();

  RxString fiatAmount = ''.obs;
  RxString walletAddress = ''.obs;

  void onAmountInputChanged(String value) {
    fiatAmount(value);
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

  bool get formIsValid =>
      validateAmount(fiatAmount.value) == null ||
      validateAddress(walletAddress.value) == null;
}
