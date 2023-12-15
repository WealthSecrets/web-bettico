import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:get/get.dart';

const int weiMultiplier = 1000000000000000000;

class SharesController extends GetxController {
  RxBool isCreatingSale = false.obs;
  RxString targetAmount = ''.obs;
  RxString duration = '1800'.obs;
  RxString startTime = ''.obs;
  RxString sharePrice = ''.obs;
  RxString subscriptionPrice = ''.obs;
  RxString maxContributions = ''.obs;
  RxString saleType = '2'.obs;

  final WalletController walletController = Get.find<WalletController>();

  void createSale() async {
    walletController.createSale(
      targetAmount.value,
      duration.value,
      startTime.value,
      sharePrice.value,
      subscriptionPrice.value,
    );
  }

  void onTargetAmountChanged(String value) {
    final double? amount = double.tryParse(value);
    if (amount != null) {
      final double fAmount = amount * weiMultiplier;
      targetAmount('${fAmount.toInt()}');
    }
  }

  void onDurationChanged(String value) {
    duration(value.trim());
  }

  void onStartTimeChanged(DateTime date) {
    startTime('${date.millisecondsSinceEpoch}');
    walletController.setRandomMessage('${date.millisecondsSinceEpoch}');
  }

  void onSharePriceChanged(String value) {
    final double? amount = double.tryParse(value);
    if (amount != null) {
      final double fAmount = amount * weiMultiplier;
      sharePrice('${fAmount.toInt()}');
    }
  }

  void onMaxContributionsChanged(String value) {
    maxContributions(value);
  }

  void onSubcriptionPriceChanged(String value) {
    final double? amount = double.tryParse(value);
    if (amount != null) {
      final double fAmount = amount * weiMultiplier;
      subscriptionPrice('${fAmount.toInt()}');
      walletController.valuesChecker.value = '${fAmount.toInt()}';
    }
  }

  void onSaleTypeChanged(String value) {
    saleType(value);
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email or username';
    }
    return errorMessage;
  }

  String? validatePhone(String? phone) {
    String? errorMessage;
    if (phone!.isEmpty) {
      errorMessage = 'Please enter your phone number.';
    }
    return errorMessage;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }
}
