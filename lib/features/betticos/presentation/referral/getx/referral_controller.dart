import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart' as validator;

class ReferralController extends GetxController {
  ReferralController({required this.referUser, required this.getReferralCode});

  final ReferUser referUser;
  final GetReferralCode getReferralCode;

  Rx<String> referralCode = ''.obs;
  RxBool isReferringUser = false.obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;

  void getTheReferralCode(BuildContext context) async {
    isLoading(true);
    final Either<Failure, User> failureOrOddsters = await getReferralCode(NoParams());
    failureOrOddsters.fold<void>(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (User u) {
        isLoading(false);
        if (u.referralCode != null) {
          referralCode(u.referralCode);
        }
      },
    );
  }

  void referralUserByEmail(BuildContext context) async {
    isReferringUser(true);
    final Either<Failure, void> failureOrOddsters = await referUser(ReferralRequest(email: email.value.trim()));
    failureOrOddsters.fold<void>(
      (Failure failure) {
        isReferringUser(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) {
        isReferringUser(false);
        AppSnacks.show(
          context,
          message: 'Referral message sent to email.',
          leadingIcon: const Icon(
            Ionicons.checkmark_sharp,
            color: Colors.white,
          ),
          backgroundColor: context.colors.success,
        );
      },
    );
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email address';
    }

    if (!validator.isEmail(email.trim())) {
      errorMessage = 'Invalid email';
    }

    return errorMessage;
  }

  void onEmailInputChanged(String value) {
    email(value.trim());
  }

  bool get formIsValid => validateEmail(email.value) == null;
}
