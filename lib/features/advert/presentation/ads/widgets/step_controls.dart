import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../getx/ads_controller.dart';
import 'action_button.dart';

class StepControls extends StatelessWidget {
  StepControls({Key? key}) : super(key: key);

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final MainAxisAlignment mainAxisAlignment = controller.currentStep.value == 0
            ? MainAxisAlignment.end
            : controller.currentStep.value == 3
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween;
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (controller.currentStep.value != 0)
              ActionButton(
                iconData: Ionicons.chevron_back_outline,
                textData: 'Back'.toUpperCase(),
                onPressed: () => controller.currentStep.value -= 1,
              ),
            if (controller.currentStep.value != 3)
              ActionButton(
                iconData: Ionicons.chevron_forward_outline,
                textData: 'Next'.toUpperCase(),
                onPressed: () => controller.currentStep.value += 1,
                reverse: true,
              ),
          ],
        );
      },
    );
  }
}
