import 'package:betticos/common/common.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/okx_controller.dart';

class NoTradingApiKey extends StatelessWidget {
  NoTradingApiKey({super.key});

  final RegisterController registerController = Get.find<RegisterController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppEmptyScreen(
        loading: registerController.isCreatingAccountApiKey.value,
        title: 'ACCESS EXPIRED',
        message: 'Your access to trading has expired, please refresh trading access.',
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
