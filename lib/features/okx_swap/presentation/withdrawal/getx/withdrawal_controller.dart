import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_history.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_request.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_response.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_withdrawal_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/withdraw.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WithdrawalController extends GetxController {
  WithdrawalController({
    required this.withdraw,
    required this.fetchWithdrawalHistory,
  });

  final Withdraw withdraw;
  final FetchWithdrawalHistory fetchWithdrawalHistory;

  RxDouble amount = 0.0.obs;
  RxString recipientAddress = ''.obs;
  Rx<Currency> currency = Currency.empty().obs;
  RxList<WithdrawalHistory> withdrawals = <WithdrawalHistory>[].obs;
  Rx<WithdrawalResponse> currentWithdrawal = WithdrawalResponse.empty().obs;
  Rx<Balance> balance = Balance.empty().obs;

  // loading variables
  RxBool isFetchingWithdrawalHistory = false.obs;
  RxBool isMakingWithdrawal = false.obs;

  void getWithdrawalHistory(BuildContext context) async {
    isFetchingWithdrawalHistory(true);

    final Either<Failure, List<WithdrawalHistory>> failureOrDeposits = await fetchWithdrawalHistory(NoParams());

    failureOrDeposits.fold<void>(
      (Failure failure) {
        isFetchingWithdrawalHistory(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<WithdrawalHistory> value) {
        isFetchingWithdrawalHistory(false);
        withdrawals(value);
      },
    );
  }

  void makeWithdrawal(BuildContext context, {VoidCallback? onSuccess}) async {
    isMakingWithdrawal(true);

    final Either<Failure, WithdrawalResponse> failureOrResponse = await withdraw(
      WithdrawalRequest(
        currency: currency.value.currency,
        chain: currency.value.chain!,
        amount: amount.value.toString(),
        fee: currency.value.minFee ?? '0.000',
        toAddress: recipientAddress.value,
        method: '4',
      ),
    );

    failureOrResponse.fold<void>(
      (Failure failure) {
        isMakingWithdrawal(false);
        AppSnacks.show(context, message: failure.message);
      },
      (WithdrawalResponse response) {
        isMakingWithdrawal(false);
        onSuccess?.call();
        currentWithdrawal(response);
        navigationController.navigateTo(
          AppRoutes.success,
          arguments: SucessScreenRouteArgument(
            title: 'Withdrawal Successful',
            message:
                'You have successfully withdrawn ${currentWithdrawal.value.amount} ${currentWithdrawal.value.currency.toUpperCase()}',
            onPressed: () {
              Navigator.of(context).pop();
              navigationController.navigateTo(AppRoutes.withdrawalHistory);
            },
          ),
        );
      },
    );
  }

  void setCurrency(Currency ccy) => currency(ccy);

  void setBalance(Balance? bal) => balance(bal ?? Balance.empty());

  void reset() {
    amount(0.0);
    recipientAddress('');
    currentWithdrawal(WithdrawalResponse.empty());
  }

  void onAmountInputChanged(String amountInString) {
    final double? amt = double.tryParse(amountInString);
    if (amt != null) {
      amount(amt);
    }
  }

  void onRecipientAddressChanged(String value) {
    recipientAddress(value);
  }

  String? onRecipientAddressValidator(String value) {
    if (value.isEmpty) {
      return 'Recipient address is required';
    }
    return null;
  }

  String? onAmountInputValidator(String amountInString) {
    final double? amount = double.tryParse(amountInString);
    if (amount == null) {
      return 'Amount is required';
    }
    return null;
  }

  bool get formIsValid => recipientAddress.value.isNotEmpty && amount.value > 0;
}
