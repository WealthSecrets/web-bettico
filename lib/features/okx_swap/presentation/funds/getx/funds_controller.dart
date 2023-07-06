import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_request.dart';
import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_response.dart';
import 'package:betticos/features/okx_swap/data/models/funds/transfer_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/fetch_transfer_history.dart';
import 'package:betticos/features/okx_swap/domain/usecases/subaccount_fund_transfer.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FundsController extends GetxController {
  FundsController({
    required this.subAccountFundTransfer,
    required this.fetchTransferHistory,
  });

  final SubAccountFundTransfer subAccountFundTransfer;
  final FetchTransferHistory fetchTransferHistory;

  RxDouble amount = 0.0.obs;
  RxString subAccount = ''.obs;
  Rx<Currency> currency = Currency.empty().obs;
  RxList<TransferHistory> transfers = <TransferHistory>[].obs;
  Rx<SubAccountFundsResponse> currentTransfer = SubAccountFundsResponse.empty().obs;
  Rx<Balance> balance = Balance.empty().obs;

  // loading variables
  RxBool isTransferring = false.obs;
  RxBool isFetchingTransferHistory = false.obs;

  void getTransferHistory(BuildContext context) async {
    isFetchingTransferHistory(true);

    final Either<Failure, List<TransferHistory>> failureOrDeposits = await fetchTransferHistory(NoParams());

    failureOrDeposits.fold<void>(
      (Failure failure) {
        isFetchingTransferHistory(false);
        AppSnacks.show(context, message: failure.message);
      },
      (List<TransferHistory> value) {
        isFetchingTransferHistory(false);
        transfers(value);
      },
    );
  }

  void transferFundsToSubAccount(BuildContext context, {VoidCallback? onSuccess}) async {
    isTransferring(true);

    final Either<Failure, SubAccountFundsResponse> failureOrResponse = await subAccountFundTransfer(
      SubAccountFundsRequest(
        from: '6',
        to: '6',
        amount: amount.value.toString(),
        currency: currency.value.currency,
        subAccount: subAccount.value.trim(),
      ),
    );

    failureOrResponse.fold<void>(
      (Failure failure) {
        isTransferring(false);
        AppSnacks.show(context, message: failure.message);
      },
      (SubAccountFundsResponse response) {
        isTransferring(false);
        currentTransfer(response);
        onSuccess?.call();
        navigationController.navigateTo(
          AppRoutes.success,
          arguments: SucessScreenRouteArgument(
            title: 'Funds Transfer Successful',
            message:
                'You have successfully transferred ${currentTransfer.value.amount} ${currentTransfer.value.currency.toUpperCase()} to ${subAccount.value}',
            onPressed: () {
              Navigator.of(context).pop();
              navigationController.navigateTo(AppRoutes.transferHistory);
            },
          ),
        );
      },
    );
  }

  void setCurrency(Currency ccy) {
    currency(ccy);
  }

  void setBalance(Balance? bal) => balance(bal ?? Balance.empty());

  void reset() {
    amount(0.0);
    subAccount('');
    currentTransfer(SubAccountFundsResponse.empty());
  }

  void onAmountInputChanged(String amountInString) {
    final double? amt = double.tryParse(amountInString);
    if (amt != null) {
      amount(amt);
    }
  }

  void onSubAccountChanged(String value) {
    subAccount(value);
  }

  String? onSubAccountValidator(String value) {
    if (value.isEmpty) {
      return 'Trading username is required';
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

  bool get formIsValid => subAccount.value.isNotEmpty && amount.value > 0;
}
