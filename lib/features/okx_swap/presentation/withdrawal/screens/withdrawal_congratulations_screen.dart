import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/getx/withdrawal_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalCongratulationsScreen extends StatelessWidget {
  WithdrawalCongratulationsScreen({Key? key}) : super(key: key);

  final WithdrawalController controller = Get.find<WithdrawalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Padding(
            padding: AppPaddings.bodyH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AssetImages.checkedColor,
                  height: 65,
                  width: 65,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Withdrawal Successful',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'You have successfully withdrew ${controller.currentWithdrawal.value.amount} ${controller.currentWithdrawal.value.currency.toUpperCase()}.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: context.colors.text,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.text,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'BACK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.primary,
                        onPressed: () {
                          Navigator.of(context).pop();
                          navigationController
                              .navigateTo(AppRoutes.withdrawalHistory);
                        },
                        child: const Text(
                          'VIEW HISTORY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
