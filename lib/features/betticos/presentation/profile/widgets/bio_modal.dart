import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BioModal extends StatefulWidget {
  const BioModal({super.key, required this.user});

  final User user;

  @override
  State<BioModal> createState() => _BioModalState();
}

class _BioModalState extends State<BioModal> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    super.initState();
    controller.setProfileUser(widget.user);
    controller.bio.value = widget.user.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        child: AppLoadingBox(
          loading: controller.isUpdatingUserProfile.value,
          child: Padding(
            padding: AppPaddings.lA,
            child: AppAnimatedColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(AppAssetIcons.closeFrame, height: 24, width: 24),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  initialValue: widget.user.bio,
                  maxLines: 5,
                  hintText: 'Write something about you',
                  errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                  validator: InputValidators.validateBio,
                  onChanged: controller.onBioInputChanged,
                ),
                const SizedBox(height: 24),
                AppButton(
                  enabled: controller.bioIsValid,
                  padding: EdgeInsets.zero,
                  backgroundColor: context.colors.primary,
                  onPressed: () async {
                    final dartz.Either<Failure, User> failurOrUser = await controller.updateProfile(context);

                    failurOrUser.fold(
                      (Failure failure) {
                        Navigator.of(context).pop();
                        controller.setUpdatingUserProfile(false);
                        AppSnacks.show(context, message: failure.message);
                      },
                      (User user) {
                        Navigator.of(context).pop();
                        controller.setUpdatingUserProfile(false);
                        bController.updateTheUser(user);
                        controller.setProfileUser(user);
                        AppSnacks.show(
                          context,
                          message: 'User profile updated successfully.',
                          backgroundColor: context.colors.success,
                          leadingIcon:
                              Image.asset(AppAssetIcons.checkCircle, height: 24, width: 24, color: Colors.white),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Save'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
