import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoTradignAccount extends StatelessWidget {
  NoTradignAccount({super.key, required this.user});

  final User user;

  final RegisterController registerController = Get.find<RegisterController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppEmptyScreen(
        loading: registerController.isCreatingOkxAccount.value,
        title: 'ENABLE TRADE',
        message: 'Your account do not have trading support yet.',
        onBottonPressed: () {
          if (user.email == null && user.firstName == null && user.username == null) {
            AppSnacks.show(context, message: 'Oops! Something went wrong.');
            return;
          }
          registerController.createOkxAccount(
            context,
            user.username ?? user.firstName ?? '',
            () {
              okxController.getUserOkxAccount(context);
              okxController.fetchAssetCurrencies(context);
              okxController.fetchConvertCurrencies(context);
              okxController.getCurrencyPair(context);
            },
          );
        },
        btnText: 'get started',
      ),
    );
  }
}
