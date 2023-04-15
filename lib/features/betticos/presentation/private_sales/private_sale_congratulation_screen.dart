import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/private_sales/getx/sales_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_transaction_history_screen.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateSaleCongratulationScreen extends StatelessWidget {
  PrivateSaleCongratulationScreen({Key? key}) : super(key: key);

  final SalesController controller = Get.find<SalesController>();

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
                  'Purchase Successful',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'You have successfully purchased ${controller.amount.value} USD worth of Xviral token.',
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
                          navigationController.navigateTo(
                            '/transactions',
                            arguments:
                                const TransactionHistoryScreenRouteArgument(
                              isSale: true,
                            ),
                          );
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
