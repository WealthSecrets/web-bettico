import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoTradignAccount extends StatelessWidget {
  NoTradignAccount(
      {Key? key, required this.user, this.isConversionScreen = false})
      : super(key: key);

  final User user;
  final bool? isConversionScreen;

  final RegisterController registerController = Get.find<RegisterController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    return AppEmptyScreen(
      title: 'ENABLE TRADE',
      message: 'Your account do not have trading support yet.',
      onBottonPressed: () {
        registerController.createOkxAccount(
          context,
          user.email.split('@').first,
          () {
            okxController.fetchAssetCurrencies(context);
            okxController.fetchConvertCurrencies(context);
            okxController.getCurrencyPair(context);
          },
        );
      },
      btnText: 'get started',
    );
  }
}
