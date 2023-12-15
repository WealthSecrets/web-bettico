// import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/shares/presentation/getx/shares_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';

class CreateShareScreen extends StatefulWidget {
  const CreateShareScreen({super.key});

  @override
  State<CreateShareScreen> createState() => _CreateShareScreenState();
}

class _CreateShareScreenState extends State<CreateShareScreen> {
  SharesController sharesController = Get.find<SharesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add New Shares'.tr, style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Obx(() {
        return AppLoadingBox(
          loading: sharesController.walletController.isCreatingSale.value,
          child: Padding(
            padding: AppPaddings.lH,
            child: AppAnimatedColumn(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AppSpacing(v: 20),
                const Notice(
                  message: 'Please all amount should be entered in Eth, we\'ll show you the equivalent in USDT.',
                ),
                const AppSpacing(v: 8),
                Text(
                  sharesController.walletController.randomMessage.value,
                  style: context.caption.copyWith(color: Colors.black),
                ),
                const AppSpacing(v: 8),
                Text(
                  sharesController.walletController.valuesChecker.value,
                  style: context.caption.copyWith(color: Colors.black),
                ),
                const AppSpacing(v: 32),
                AppTextInput(
                  labelText: 'Target Amount'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: sharesController.onTargetAmountChanged,
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Share Price'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: sharesController.onSharePriceChanged,
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Subscription Price'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: sharesController.onSubcriptionPriceChanged,
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'No. of Contributors'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: sharesController.onMaxContributionsChanged,
                ),
                const AppSpacing(v: 8),
                TextButton(
                  onPressed: () {
                    DatePickerBdaya.showDateTimePicker(
                      context,
                      onChanged: sharesController.onStartTimeChanged,
                      onConfirm: sharesController.onStartTimeChanged,
                      currentTime: DateTime.now(),
                    );
                  },
                  child: const Text(
                    'Pick Start Date & Time',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Duration'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: (String value) {},
                ),
                const AppSpacing(v: 49),
                AppButton(
                  borderRadius: AppBorderRadius.largeAll,
                  onPressed: () {
                    sharesController.createSale();
                  },
                  child: Text(
                    'Create Shares'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const AppSpacing(v: 50),
              ],
            ),
          ),
        );
      }),
    );
  }
}
