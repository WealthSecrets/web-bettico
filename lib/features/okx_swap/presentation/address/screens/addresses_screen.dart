import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/widgets.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<AddressesScreen> {
  final OkxController controller = Get.find<OkxController>();
  final RegisterController registerController = Get.find<RegisterController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.getUserOkxAccount(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Wallet Addresses',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
        ),
      ),
      body: Obx(() {
        final User user = Get.find<BaseScreenController>().user.value;
        final List<OkxAddress>? addresses = controller.myOkxAccount.value.addresses;
        return AppLoadingBox(
          loading: controller.isGettingOkxAccount.value ||
              registerController.isCreatingOkxAccount.value ||
              registerController.isCreatingAccountApiKey.value,
          child: user.okx != null
              ? addresses != null && addresses.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final OkxAddress address = addresses[index];
                          return OptionCard(
                            title: address.currency,
                            subtitle: address.address,
                            backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
                            onPressed: () async {
                              controller.setSelectedCurrency(address.currency);
                              await showMaterialModalBottomSheet<void>(
                                bounce: true,
                                animationCurve: Curves.fastLinearToSlowEaseIn,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: MediaQuery.of(context).size.height * .6,
                                      minHeight: MediaQuery.of(context).size.height * .5,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                      child: AddressDetails(address: address),
                                    ),
                                  );
                                },
                                context: context,
                              );
                            },
                            onCopy: () {
                              Clipboard.setData(ClipboardData(text: address.address));

                              AppSnacks.show(
                                context,
                                message: 'Address copied to clipboard',
                                backgroundColor: context.colors.success,
                                leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, size: 20, color: Colors.white),
                              );
                            },
                          );
                        },
                        itemCount: addresses.length,
                      ),
                    )
                  : AppEmptyScreen(
                      message: 'You do not have any deposit address yet.',
                      onBottonPressed: () => navigationController.navigateTo(AppRoutes.currencies),
                      btnText: 'new address',
                    )
              : NoTradignAccount(user: user),
        );
      }),
    );
  }
}
