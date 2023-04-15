import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/requests/reset_request/reset_request.dart';
import 'package:betticos/features/auth/domain/usecases/reset_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class ResetController extends GetxController {
  ResetController({
    required this.resetPassword,
  });
  final ResetPassword resetPassword;

  RxBool isObscured = true.obs;
  RxBool isLoading = false.obs;
  RxString confirmPassword = ''.obs;
  RxString resetCode = ''.obs;
  RxString password = ''.obs;

  void togglePasswordVisibility() {
    isObscured(!isObscured.value);
  }

  void reset(BuildContext context, String email) async {
    // ignore: unawaited_futures
    isLoading(true);

    final Either<Failure, User> failureOrUser = await resetPassword(
      ResetRequest(
        confirmPassword: confirmPassword.value,
        password: password.value,
        email: email,
      ),
    );

    // ignore: unawaited_futures
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
      },
      (User user) {
        isLoading(false);
        Get.offAllNamed<void>('/login');
        AppSnacks.show(context,
            message: 'Password reset successfully. Please login again.');
      },
    );
  }

  void onConfirmPasswordInputChanged(String value) {
    confirmPassword(value.trim());
  }

  void onPasswordInputChanged(String value) {
    password(value.trim());
  }

  void onResetInputChanged(String value) {
    resetCode.value = value;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  // String? validateResetCode(String? resetCode) {
  //   String? errorMessage;
  //   if (resetCode!.isEmpty) {
  //     errorMessage = 'Please reset code is required';
  //   }
  //   if (resetCode.length != 6) {
  //     errorMessage = 'Reset code is invalid';
  //   }
  //   return errorMessage;
  // }

  String? validateConfirmPassword(String? confirm) {
    String? errorMessage;
    if (confirm!.isEmpty) {
      errorMessage = 'Please enter password';
    }

    if (password.value != confirmPassword.value) {
      errorMessage = 'Passwords do not match.';
    }

    return errorMessage;
  }

  bool get formIsValid =>
      validatePassword(password.value) == null &&
      validateConfirmPassword(confirmPassword.value) == null;
}
