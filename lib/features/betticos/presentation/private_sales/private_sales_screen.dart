import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/notice.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/private_sales/getx/sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PrivateSale extends StatefulWidget {
  const PrivateSale({Key? key}) : super(key: key);

  @override
  State<PrivateSale> createState() => _PrivateSaleState();
}

class _PrivateSaleState extends State<PrivateSale> {
  final SalesController controller = Get.find<SalesController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    final double xRate = bController.setup.value.xviralRate;
    return Scaffold(
      body: Obx(
        () {
          final bool hasAmount = controller.convertedAmount.value > 0;
          return AppLoadingBox(
            loading: bController.isGettingSetup.value,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: 16.0,
                left: 16.0,
              ),
              child: Column(children: <Widget>[
                AppAnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Private Sales',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Notice(
                      message:
                          'Please make sure you only purchase private sale from betticos.io to prevent loss of funds.',
                    ),
                    const SizedBox(height: 32),
                    StepProgressIndicator(
                      totalSteps: 500000,
                      currentStep: 35000,
                      size: 8,
                      padding: 0,
                      selectedColor: context.colors.primary,
                      unselectedColor: context.colors.lightGrey,
                      roundedEdges: const Radius.circular(10),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '35000 USD',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: context.colors.textDark,
                          ),
                        ),
                        Text(
                          '500000 USD',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: context.colors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    AppTextInput(
                      labelText: 'AMOUNT (USDT)',
                      textInputType: TextInputType.number,
                      onChanged: (String value) {
                        final double? amount = double.tryParse(value);
                        if (amount != null) {
                          controller.onAmountInputChanged(amount);
                          controller.convertAmount(xRate);
                        } else {
                          controller.resetValues();
                        }
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(' '),
                      ],
                      backgroundColor: context.colors.primary.shade50,
                      validator: controller.validateAmount,
                    ),
                    const AppSpacing(v: 4),
                    Obx(
                      () => Text(
                        controller.convertedAmount.value == 0.0
                            ? 'No USD to convert'
                            : 'USD coverted to Xviral: ${controller.convertedAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: hasAmount
                              ? context.colors.success
                              : context.colors.text,
                          fontWeight:
                              hasAmount ? FontWeight.bold : FontWeight.normal,
                          fontStyle:
                              hasAmount ? FontStyle.normal : FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  enabled: true,
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () {},
                  child: const Text(
                    'PURCHASE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ]),
            ),
          );
        },
      ),
    );
  }
}
