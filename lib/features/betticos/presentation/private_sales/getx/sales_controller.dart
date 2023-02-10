import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/transaction/get_user_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  SalesController({
    required this.getUserStats,
  });

  final GetUserStats getUserStats;

  RxDouble amount = 0.0.obs;
  RxDouble convertedAmount = 0.0.obs;
  Rx<UserStats> stats = UserStats.empty().obs;
  RxBool isGettingStats = false.obs;

  void fetchUserStats(BuildContext context) async {
    isGettingStats(true);
    final Either<Failure, UserStats> failureOrUserStats =
        await getUserStats(NoParams());

    failureOrUserStats.fold<void>(
      (Failure failure) {
        isGettingStats(false);
        AppSnacks.show(context, message: failure.message);
      },
      (UserStats userStats) {
        isGettingStats(false);
        stats(userStats);
      },
    );
  }

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
