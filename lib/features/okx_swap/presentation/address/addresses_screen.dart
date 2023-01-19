// import 'package:auto_size_text/auto_size_text.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressesScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<AddressesScreen> {
  final OkxController controller = Get.find<OkxController>();

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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: context.colors.textDark,
          ),
        ),
      ),
      body: Obx(() {
        final List<OkxAddress> addresses =
            controller.myOkxAccount.value.addresses;
        return AppLoadingBox(
          loading: controller.isGettingOkxAccount.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final OkxAddress address = addresses[index];
                return OptionCard(
                  title: address.currency,
                  subtitle: address.address,
                  backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
                  onPressed: () {},
                  onCopy: () {},
                );
              },
              itemCount: addresses.length,
            ),
          ),
        );
      }),
    );
  }
}
