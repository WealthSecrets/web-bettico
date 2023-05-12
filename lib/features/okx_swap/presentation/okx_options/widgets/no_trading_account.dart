import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoTradignAccount extends StatelessWidget {
  NoTradignAccount({Key? key, required this.user}) : super(key: key);

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
          if (user.email == null &&
              user.firstName == null &&
              user.username == null) {
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
