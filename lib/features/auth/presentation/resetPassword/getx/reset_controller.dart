import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/requests/reset_request/reset_request.dart';
import 'package:betticos/features/auth/domain/usecases/reset_password.dart';
import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
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
    isLoading(true);

    final Either<Failure, User> failureOrUser = await resetPassword(
      ResetRequest(
        confirmPassword: confirmPassword.value,
        password: password.value,
        email: email,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (User user) {
        isLoading(false);
        Get.toNamed<void>(LoginScreen.route);
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
      validatePassword(password.value) == null && validateConfirmPassword(confirmPassword.value) == null;
}
