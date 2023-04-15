import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart' as validator;
import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/requests/forgot_request/forgot_request.dart';
import '/features/auth/domain/usecases/forgot_password.dart';

class ForgotController extends GetxController {
  ForgotController({
    required this.forgotPassword,
  });
  final ForgotPassword forgotPassword;

  RxBool isLoading = false.obs;
  RxString email = ''.obs;

  void forgot(BuildContext context) async {
    // ignore: unawaited_futures
    isLoading(true);

    final Either<Failure, User> failureOrUser = await forgotPassword(
      ForgotRequest(
        email: email.value,
      ),
    );

    // ignore: unawaited_futures
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
      },
      (User user) {
        isLoading(false);
        Get.toNamed<void>('/wallet_connect');
      },
    );
  }

  void nextToRest(BuildContext context) {
    Get.toNamed<void>('/reset_password');
  }

  void onEmailInputChanged(String value) {
    email(value.trim());
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

  bool get formIsValid => validateEmail(email.value) == null;
}
