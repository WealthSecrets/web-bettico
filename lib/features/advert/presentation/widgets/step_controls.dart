import 'package:betticos/features/advert/presentation/getx/getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'action_button.dart';

class StepControls extends StatelessWidget {
  StepControls({super.key});
  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final MainAxisAlignment mainAxisAlignment =
            controller.currentStep.value == 0 ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween;
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            if (controller.currentStep.value != 0)
              ActionButton(
                iconData: Ionicons.chevron_back_outline,
                textData: 'Back'.toUpperCase(),
                onPressed: () => controller.currentStep.value -= 1,
              ),
            ActionButton(
              iconData: Ionicons.chevron_forward_outline,
              textData: controller.currentStep.value == 3 ? 'Confirm'.toUpperCase() : 'Next'.toUpperCase(),
              onPressed: () {
                if (controller.currentStep.value != 3) {
                  controller.currentStep.value += 1;
                } else {
                  controller.addAdvert(context);
                }
              },
              reverse: true,
            ),
          ],
        );
      },
    );
  }
}
