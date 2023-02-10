import 'package:get/get.dart';

class SalesController extends GetxController {
  SalesController();

  RxDouble amount = 0.0.obs;
  RxDouble convertedAmount = 0.0.obs;

  void onAmountInputChanged(double value) {
    amount(value);
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

  void convertAmount(double xRate) => convertedAmount(xRate * amount.value);

  void resetValues() {
    amount(0.0);
    convertedAmount(0.0);
  }
}
