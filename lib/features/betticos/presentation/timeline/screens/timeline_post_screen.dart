import 'dart:io';

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/arguments/add_post_comment_argument.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/core/core.dart';
import '/core/presentation/widgets/full_image.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';

class TimelinePostScreen extends StatefulWidget {
  const TimelinePostScreen({Key? key}) : super(key: key);
  @override
  _TimelinePostScreenState createState() => _TimelinePostScreenState();
}

class _TimelinePostScreenState extends State<TimelinePostScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  final TimelineController timelineController = Get.find<TimelineController>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController postTextController = TextEditingController();
  final BaseScreenController controller = Get.find<BaseScreenController>();
  final SettingsController sController = Get.find<SettingsController>();

  // likk_picker
  // late final GalleryController likkController;
  // late final ValueNotifier<List<LikkEntity>> notifier;

  RxList<File> files = <File>[].obs;
  GlobalKey imageBtn = GlobalKey();
  GlobalKey slipBtn = GlobalKey();
  GlobalKey sendBtn = GlobalKey();

  void _onPickImage() async {
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
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

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  Future<void> showTutorial() async {
    if (sController.isPostIntro.value) {
      initTargets();
      tutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: context.colors.primary,
        textSkip: 'SKIP',
        paddingFocus: 10,
        opacityShadow: 0.8,
        onFinish: () {
          sController.updatePostIntroductionPreference(false);
        },
        onClickTarget: (TargetFocus target) {},
        onClickOverlay: (TargetFocus target) {},
        onSkip: () {
          sController.updatePostIntroductionPreference(false);
        },
      )..show(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AddPostCommentArgument? args =
        ModalRoute.of(context)?.settings.arguments as AddPostCommentArgument?;
    return Obx(
      () => AppLoadingBox(
        loading: timelineController.isAddingPost.value ||
            timelineController.isAddingComment.value,
        child: WillPopScope(
          onWillPop: () {
            timelineController.resetValuesAfterPost();
            return Future<bool>.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Ionicons.close,
                  size: 24,
                ),
                color: context.colors.black,
                onPressed: () {
                  timelineController.resetValuesAfterPost();
                  Navigator.of(context).pop();
                },
              ),
            ),
            bottomSheet: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.colors.lightGrey,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            if (ResponsiveWidget.isSmallScreen(context)) {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: ((BuildContext context) =>
                                    bottomSheet()),
                              );
                            } else {
                              _onPickImage();
                            }
                          },
                          icon: Icon(
                            Ionicons.image_outline,
                            size: 24,
                            color: context.colors.primary,
                            key: imageBtn,
                          ),
                        ),
                        const AppSpacing(h: 5),
                        if (controller.user.value.role == 'oddster')
                          IconButton(
                            onPressed: () {
                              showSlipCodeDialog(context);
                            },
                            icon: Icon(
                              Ionicons.football_outline,
                              size: 24,
                              color: context.colors.primary,
                            ),
                            key: slipBtn,
                          ),
                      ],
                    ),
                  ),
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
                  const AppSpacing(h: 8),
                  IconButton(
                    onPressed: () {
                      if (!timelineController.timelineIsInvalid) {
                        if (args != null) {
                          timelineController.addNewPost(context,
                              isReply: true, postId: args.postId);
                        } else {
                          timelineController.addNewPost(context);
                        }
                      }
                    },
                    icon: Icon(
                      Ionicons.send_sharp,
                      size: 24,
                      color: timelineController.timelineIsInvalid
                          ? context.colors.primary.shade100
                          : context.colors.primary,
                      key: sendBtn,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: AppPaddings.lH.add(AppPaddings.lB),
                  child: TextField(
                    controller: postTextController,
                    onChanged: timelineController.onTextInputChanged,
                    maxLength: timelineController.maxTextLength.value,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText:
                            args != null ? 'add_reply'.tr : 'have_to_say'.tr,
                        hintStyle: const TextStyle(fontSize: 16),
                        counterStyle: const TextStyle(fontSize: 16)),
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colors.black,
                    ),
                  ),
                ),
                const AppSpacing(v: 30),
                Obx(() {
                  return timelineController.slipCode.isNotEmpty
                      ? Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: ResponsiveWidget.isSmallScreen(context)
                                  ? MediaQuery.of(context).size.width - 32
                                  : 600 - 32,
                              padding: AppPaddings.lL,
                              decoration: BoxDecoration(
                                color: context.colors.lightGrey,
                              ),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SelectableText(
                                        '${'slip_code'.tr}: ${timelineController.slipCode.value}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: context.colors.text,
                                        ),
                                      ),
                                    ),
                                    const AppSpacing(h: 10),
                                    IconButton(
                                      onPressed: () {
                                        showRemoveSlipCodeOptionDialog(context);
                                      },
                                      icon: Icon(
                                        Ionicons.trash_outline,
                                        color: context.colors.error,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink();
                }),
                const AppSpacing(v: 30),
                SizedBox(
                  height: 175.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: timelineController.files.length,
                    itemBuilder: (BuildContext context, int index) => Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => FullImage(
                                  image: timelineController.files[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 170,
                            width: 150,
                            margin: AppPaddings.lL,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: MemoryImage(
                                  timelineController.files[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            child: const Icon(
                              Ionicons.close_circle_sharp,
                              color: Colors.red,
                              size: 20,
                            ),
                            onTap: () {
                              timelineController.removeImage(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSlipCodeDialog(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => Column(
        children: <Widget>[
          const Spacer(),
          SizedBox(
            width: ResponsiveWidget.isSmallScreen(context) ? null : 400,
            height: ResponsiveWidget.isSmallScreen(context) ? null : 300,
            child: AppTextDailogModal(
              controller: textController,
              modalContext: context,
              onChanged: (String value) {},
              onAffrimButtonPressed: () {
                timelineController
                    .onSlipCodeFieldSubmitted(textController.text);
              },
              affirmButtonText: 'ADD CODE',
              title: 'Odds Slip code',
              onCancelledPressed: () => Get.back<void>(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void showRemoveSlipCodeOptionDialog(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => AppOptionDialogueModal(
        modalContext: context,
        title: 'remove_slip_code'.tr,
        backgroundColor: context.colors.error,
        message: 'sure_remove_code'.tr,
        affirmButtonText: 'remove'.tr.toUpperCase(),
        onPressed: () => timelineController.resetSlipCodeValue(),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'choose_img'.tr,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            IconButton(
              icon: const Icon(
                Ionicons.camera,
              ),
              onPressed: _onPickImage,
            ),
            IconButton(
              icon: const Icon(
                Ionicons.image,
              ),
              onPressed: _onPickImage,
            ),
          ])
        ],
      ),
    );
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: 'imageBtn',
        keyTarget: imageBtn,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            align: ContentAlign.top,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'img_post_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'slipBtn',
        keyTarget: slipBtn,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            align: ContentAlign.top,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'slip_code_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'sendBtn',
        keyTarget: sendBtn,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            align: ContentAlign.top,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'send_post_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
