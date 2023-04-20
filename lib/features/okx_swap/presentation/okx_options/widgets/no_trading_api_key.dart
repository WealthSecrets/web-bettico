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
    return AppEmptyScreen(
      title: 'ACCESS EXPIRED',
      message: 'Your access to trading has expired, please refresh trading access.',
      onBottonPressed: () {
        registerController.createOkxAccountApiKey(context);
      },
      btnText: 'Refresh Access',
    );
  }
}
