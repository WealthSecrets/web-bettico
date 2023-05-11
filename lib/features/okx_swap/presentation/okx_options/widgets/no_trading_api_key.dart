import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoTradingApiKey extends StatelessWidget {
  NoTradingApiKey({Key? key}) : super(key: key);

  final RegisterController registerController = Get.find<RegisterController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppEmptyScreen(
        loading: registerController.isCreatingAccountApiKey.value,
        title: 'ACCESS EXPIRED',
        message:
            'Your access to trading has expired, please refresh trading access.',
        onBottonPressed: () {
          registerController.createOkxAccountApiKey(
            context,
            () {
              okxController.getUserOkxAccount(context);
            },
          );
        },
        btnText: 'Refresh Access',
      ),
    );
  }
}
