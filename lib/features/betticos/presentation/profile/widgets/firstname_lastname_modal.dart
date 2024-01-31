import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstNameLastNameModal extends StatefulWidget {
  const FirstNameLastNameModal({super.key, required this.user});

  final User user;

  @override
  State<FirstNameLastNameModal> createState() => _FirstNameLastNameModalState();
}

class _FirstNameLastNameModalState extends State<FirstNameLastNameModal> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    super.initState();
    controller.setProfileUser(widget.user);
    controller.firstName.value = widget.user.firstName ?? '';
    controller.lastName.value = widget.user.lastName ?? '';
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
                  initialValue: widget.user.firstName,
                  hintText: 'Your first name',
                  errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                  validator: (String value) => InputValidators.validateName(value, title: 'First name'),
                  onChanged: controller.onFirstNameInputChanged,
                ),
                AppTextInput(
                  initialValue: widget.user.lastName,
                  hintText: 'Your last name',
                  errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                  validator: (String value) => InputValidators.validateName(value, title: 'Last name'),
                  onChanged: controller.onLastNameInputChanged,
                ),
                const SizedBox(height: 24),
                AppButton(
                  enabled: controller.isNameProvided &&
                      (controller.firstName.value != widget.user.firstName ||
                          controller.lastName.value != widget.user.lastName),
                  padding: EdgeInsets.zero,
                  backgroundColor: context.colors.primary,
                  onPressed: () async {
                    final dartz.Either<Failure, User> failurOrUser = await controller.updateProfile(context);

                    failurOrUser.fold((Failure failure) {
                      Navigator.of(context).pop();
                      controller.setUpdatingUserProfile(false);
                      AppSnacks.show(context, message: failure.message);
                    }, (User user) {
                      Navigator.of(context).pop();
                      controller.setUpdatingUserProfile(false);
                      bController.updateTheUser(user);
                      controller.setProfileUser(user);
                      AppSnacks.show(
                        context,
                        message: 'User profile updated successfully.',
                        backgroundColor: context.colors.success,
                        leadingIcon: Image.asset(AppAssetIcons.checkCircle, height: 24, width: 24, color: Colors.white),
                      );
                    });
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
