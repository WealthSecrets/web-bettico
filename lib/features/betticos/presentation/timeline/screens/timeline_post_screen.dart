import 'dart:io';

import 'package:betticos/assets/app_asset_icons.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TimelinePostScreen extends StatefulWidget {
  const TimelinePostScreen({super.key});

  @override
  State<TimelinePostScreen> createState() => _TimelinePostScreenState();
}

class _TimelinePostScreenState extends State<TimelinePostScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  final TimelineController timelineController = Get.find<TimelineController>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController postTextController = TextEditingController();
  final BaseScreenController controller = Get.find<BaseScreenController>();
  final SettingsController sController = Get.find<SettingsController>();

  RxList<File> files = <File>[].obs;
  GlobalKey imageBtn = GlobalKey();
  GlobalKey slipBtn = GlobalKey();
  GlobalKey sendBtn = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AddPostCommentArgument? args = ModalRoute.of(context)?.settings.arguments as AddPostCommentArgument?;
    return Obx(
      () => AppLoadingBox(
        loading: timelineController.isAddingPost.value || timelineController.isAddingComment.value,
        child: WillPopScope(
          onWillPop: () {
            timelineController.resetValuesAfterPost();
            return Future<bool>.value(true);
          },
          child: Scaffold(
            bottomSheet: PostBottomSheet(),
            body: Column(
              children: <Widget>[
                TopBar(timelineController: timelineController, args: args),
                Padding(
                  padding: AppPaddings.lH,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Avatar(
                      imageUrl:
                          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=800',
                    ),
                  ),
                ),
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
                      hintText: args != null && args.isReply
                          ? 'add_reply'.tr
                          : args != null && !args.isReply
                              ? 'Add a comment'
                              : 'What\'s happening?',
                      hintStyle: const TextStyle(fontSize: 16),
                      counterText: '',
                    ),
                    style: TextStyle(fontSize: 16, color: context.colors.black),
                  ),
                ),
                if (timelineController.slipCode.isNotEmpty) ...<Widget>[
                  const AppSpacing(v: 30),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width:
                            ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width - 32 : 600 - 32,
                        padding: AppPaddings.lL,
                        decoration: BoxDecoration(color: context.colors.lightGrey),
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
                                onPressed: () => WidgetUtils.showRemoveSlipCodeOptionDialog(
                                  context,
                                  onPressed: timelineController.resetSlipCodeValue,
                                ),
                                icon: Icon(Ionicons.trash_outline, color: context.colors.error, size: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (timelineController.files.isNotEmpty) ...<Widget>[const AppSpacing(v: 30), PostImagesListview()],
                if (args != null && !args.isReply) Padding(padding: AppPaddings.lH, child: ActualPost(post: args.post)),
                const Spacer(),
                Padding(
                  padding: AppPaddings.lH,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => WidgetUtils.showOptionsBottomSheet(
                        context,
                        options: <OptionArgument>[
                          OptionArgument(icon: AppAssetIcons.userGradient, title: 'Everyone', onPressed: () {}),
                          OptionArgument(icon: AppAssetIcons.flagGrad, title: 'Sensitive', onPressed: () {}),
                        ],
                        title: 'Choose Viewers',
                      ),
                      child: const AppTag(text: 'Everyone', icon: AppAssetIcons.flag),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
