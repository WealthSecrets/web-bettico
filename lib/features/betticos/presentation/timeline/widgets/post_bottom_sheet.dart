import 'dart:io';

import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/presentation/presentation.dart';
import 'package:betticos/features/presentation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PostBottomSheet extends StatelessWidget {
  PostBottomSheet({super.key});

  final TimelineController timelineController = Get.find<TimelineController>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController postTextController = TextEditingController();
  final BaseScreenController controller = Get.find<BaseScreenController>();
  final SettingsController sController = Get.find<SettingsController>();

  final RxList<File> files = <File>[].obs;
  final GlobalKey imageBtn = GlobalKey();
  final GlobalKey slipBtn = GlobalKey();
  final GlobalKey sendBtn = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colors.lightGrey))),
        child: Padding(
          padding: AppPaddings.lH,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 24,
                width: 24,
                child: CircularStepProgressIndicator(
                  totalSteps: timelineController.maxTextLength.value,
                  currentStep: timelineController.text.value.length,
                  stepSize: 3,
                  selectedColor: context.colors.primary,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  selectedStepSize: 3,
                  roundedCap: (_, __) => true,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (ResponsiveWidget.isSmallScreen(context)) {
                    showModalBottomSheet<void>(context: context, builder: bottomSheet);
                  } else {
                    _onPickImage();
                  }
                },
                icon: Icon(Ionicons.image_outline, size: 24, color: context.colors.primary, key: imageBtn),
              ),
              if (controller.user.value.role == 'oddster')
                IconButton(
                  onPressed: () => WidgetUtils.showSlipCodeDialog(
                    context,
                    controller: textController,
                    onAffrimButtonPressed: () => timelineController.onSlipCodeFieldSubmitted(textController.text),
                  ),
                  icon: Icon(Ionicons.football_outline, size: 24, color: context.colors.primary),
                  key: slipBtn,
                ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppAssetIcons.moreHorz,
                  height: 24,
                  width: 24,
                  color: const Color(0xFF707281),
                  key: sendBtn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text('choose_img'.tr, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: const Icon(Ionicons.camera), onPressed: _onPickImage),
              IconButton(icon: const Icon(Ionicons.image), onPressed: _onPickImage),
            ],
          )
        ],
      ),
    );
  }

  void _onPickImage() async {
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
      allowedExtensions: <String>['png', 'jpg', 'jpeg'],
    );

    if (picked != null) {
      final Uint8List? bytes = picked.files.first.bytes;

      if (bytes != null) {
        timelineController.onFileChanged(bytes);
      }
    }
  }
}
