import 'package:betticos/features/auth/domain/requests/update_user_role/update_user_role_request.dart';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';
import 'package:betticos/features/auth/domain/usecases/update_user_role.dart';
import 'package:betticos/features/auth/domain/usecases/verify_user.dart';
import 'package:betticos/features/auth/presentation/register/arguments/otp_verification_screen_argument.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';
import 'package:betticos/features/okx_swap/domain/usecases/create_subaccount.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:validators/validators.dart' as validator;

import '/core/core.dart';
import '/features/auth/data/models/responses/twilio/twilio_response.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/requests/identification/identification_request.dart';
import '/features/auth/domain/requests/register_request/register_request.dart';
import '/features/auth/domain/requests/sms/send_sms_request.dart';
import '/features/auth/domain/requests/update_photo_request.dart/update_photo_request.dart';
import '/features/auth/domain/requests/verify_email/verify_email_request.dart';
import '/features/auth/domain/requests/verify_sms/verify_sms_request.dart';
import '/features/auth/domain/usecases/register_user.dart';
import '/features/auth/domain/usecases/send_sms.dart';
import '/features/auth/domain/usecases/update_profile.dart';
import '/features/auth/domain/usecases/update_user_profile_photo.dart';
import '/features/auth/domain/usecases/upload_identification.dart';
import '/features/auth/domain/usecases/verify_email.dart';
import '/features/auth/domain/usecases/verify_sms.dart';
import '/features/auth/presentation/login/getx/login_controller.dart';
import '/features/betticos/domain/requests/update_request/update_request.dart';

class RegisterController extends GetxController {
  RegisterController({
    required this.registerUser,
    required this.verifySms,
    required this.verifyEmail,
    required this.verifyUser,
    required this.updateProfile,
    required this.sendSms,
    required this.uploadIdentifcation,
    required this.createSubAccount,
    required this.updateUserProfilePhoto,
    required this.updateUserRole,
  });

  final RegisterUser registerUser;
  final VerifySms verifySms;
  final VerifyEmail verifyEmail;
  final UpdateProfile updateProfile;
  final SendSms sendSms;
  final UploadIdentifcation uploadIdentifcation;
  final UpdateUserProfilePhoto updateUserProfilePhoto;
  final CreateSubAccount createSubAccount;
  final UpdateUserRole updateUserRole;
  final VerifyUser verifyUser;

  // instance of register controller
  static RegisterController instance = Get.find();

  // reactive variables
  RxBool isSignUpAsOddster = false.obs;
  RxBool isObscured = true.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  Rx<DateTime> dateOfBirth = DateTime.now().obs;
  RxString email = ''.obs;
  RxString referralCode = ''.obs;
  RxString username = ''.obs;
  RxString phone = ''.obs;
  RxString photo = ''.obs;
  RxString role = ''.obs;
  RxString type = 'email'.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxString otpCode = ''.obs;
  RxString identificationType = 'Passport'.obs;
  RxString identificationNumber = ''.obs;
  RxString okxUsername = ''.obs;
  Rx<DateTime> expiryDate = DateTime.now().obs;
  RxDouble uploadPercentage = 0.0.obs;
  Rx<Uint8List> docImage = Uint8List.fromList(<int>[]).obs;
  Rx<Uint8List> profileImage = Uint8List.fromList(<int>[]).obs;
  RxBool useUsername = false.obs;

  // loading values
  RxBool isRegisteringUser = false.obs;
  RxBool isAddingPersonalInformation = false.obs;
  RxBool isVerifyingOTP = false.obs;
  RxBool isSendingSms = false.obs;
  RxBool isAddingDocument = false.obs;
  RxBool isAddingProfileImage = false.obs;
  RxBool isUpdatingUserRole = false.obs;
  RxBool isCheckingUserExistence = false.obs;
  RxBool isCreatingOkxAccount = false.obs;

  // enums reactive variables
  Rx<AccountType> accountType = AccountType.personal.obs;

  // controllers
  final LoginController lController = Get.find<LoginController>();
  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();
  final LiveScoreController wController = Get.find<LiveScoreController>();

  // social authentication
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void toggleSignUpAsOddster() {
    isSignUpAsOddster(!isSignUpAsOddster.value);
    role(isSignUpAsOddster.value ? 'oddster' : 'user');
  }

  void togglePasswordVisibility() {
    isObscured(!isObscured.value);
  }

  void sendSmstoPhoneNumber(BuildContext context, {User? u}) async {
    isSendingSms(true);
    final Either<Failure, TwilioResponse> fialureOrSuccess = await sendSms(
      SendSmsRequest(
        phone: phone.value,
      ),
    );

    fialureOrSuccess.fold((Failure failure) {
      isSendingSms(false);
      AppSnacks.show(context, message: failure.message);
    }, (TwilioResponse value) {
      isSendingSms(false);
      Get.toNamed<void>(
        AppRoutes.otpVerifyPhone,
        arguments: OTPVerificationScreenArgument(
          user: u,
        ),
      );
    });
  }

  void verifyUserPhoneNumber(BuildContext context, {User? u}) async {
    isVerifyingOTP(true);

    final Either<Failure, User> fialureOrSuccess = await verifySms(
        VerifySmsRequest(
            code: otpCode.value, phone: u != null ? u.phone! : phone.value));

    fialureOrSuccess.fold((Failure failure) {
      isVerifyingOTP(false);
      resetOtpCodeField();
      AppSnacks.show(context, message: failure.message);
    }, (User value) {
      isVerifyingOTP(false);
      resetOtpCodeField();
      if (u != null) {
        lController.reRouteOddster(context, value);
      } else {
        Get.offNamed<void>(AppRoutes.home);
      }
    });
  }

  void verifyUserEmailAddress(BuildContext context, {User? u}) async {
    isVerifyingOTP(true);

    final Either<Failure, User> fialureOrSuccess = await verifyEmail(
      VerifyEmailRequest(
        code: otpCode.value,
        email: u != null && u.email != null ? u.email! : email.value,
      ),
    );

    fialureOrSuccess.fold((Failure failure) {
      isVerifyingOTP(false);
      resetOtpCodeField();
      AppSnacks.show(context, message: failure.message);
    }, (User value) {
      isVerifyingOTP(false);
      otpCode('');
      resetOtpCodeField();
      if (u != null) {
        lController.reRouteOddster(context, value);
      } else {
        Get.offNamed<void>(AppRoutes.accountType);
      }
    });
  }

  void resetOtpCodeField() {
    otpCode('');
  }

  void uploadUserIdentification(BuildContext context) async {
    isAddingDocument(true);

    final Either<Failure, User> fialureOrSuccess = await uploadIdentifcation(
      IdentificationRequest(
        expiryDate: expiryDate.value,
        identificationNumber: identificationNumber.value,
        identificationType: identificationType.value,
        file: docImage.value,
      ),
    );

    fialureOrSuccess.fold((Failure failure) {
      isAddingDocument(false);
      AppSnacks.show(context, message: failure.message);
    }, (User u) {
      isAddingDocument(false);
      baseScreenController.updateTheUser(u);
      lController.reRouteOddster(context, u);
    });
  }

  void registerWithGoogleAuth(BuildContext context,
      {bool isRequestFromLogin = false}) async {
    type('google');

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final String googleEmail = googleSignInAccount.email;
        final String? displayName = googleSignInAccount.displayName;
        final String? photoUrl = googleSignInAccount.photoUrl;
        final GoogleSignInAuthentication kd =
            await googleSignInAccount.authentication;
        email(googleEmail);
        if (displayName != null) {
          username(displayName);
        }
        if (photoUrl != null) {
          photo(photoUrl);
        }
        if (kd.idToken != null) {
          final Either<Failure, User> failureOrSuccess = await verifyUser(
            VerifyUserRequest(email: googleEmail, token: kd.idToken!),
          );
          failureOrSuccess.fold((Failure failure) {
            AppSnacks.show(
              context,
              message: failure.message,
            );
          }, (User user) {
            lController.controller.user(user);
            lController.reRouteOddster(context, user);
          });
        }
      }
    } catch (error) {
      await AppSnacks.show(
        context,
        message: 'Failed to authenticate with Google',
      );
    }
  }

  void toggleOkxUsername(bool checked) {
    useUsername(checked);
  }

  void updateTheUserProfilePhoto(BuildContext context) async {
    isAddingProfileImage(true);

    final Either<Failure, User> fialureOrSuccess = await updateUserProfilePhoto(
      UpdatePhotoRequest(
        file: profileImage.value,
        onSendProgress: (int count, int total) {
          uploadPercentage(count / total);
        },
      ),
    );

    fialureOrSuccess.fold((Failure failure) {
      isAddingProfileImage(false);
      AppSnacks.show(context, message: failure.message);
    }, (User value) {
      isAddingProfileImage(false);
      baseScreenController.updateTheUser(value);
      Get.offAllNamed<void>(AppRoutes.home);
      menuController.changeActiveItemTo(AppRoutes.timeline);
    });
  }

  void register(BuildContext context, {bool isWalletConnect = false}) async {
    isRegisteringUser(true);

    final Either<Failure, User> failureOrUser = await registerUser(
      RegisterRequest(
        confirmPassword: confirmPassword.value,
        password: password.value,
        wallet: wController.walletAddress.value.isNotEmpty
            ? wController.walletAddress.value
            : null,
        email: !isWalletConnect ? email.value : null,
        referralCode: referralCode.value.isNotEmpty ? referralCode.value : null,
        type: isWalletConnect ? 'wallet' : type.value.trim(),
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isRegisteringUser(false);
        AppSnacks.show(context, message: failure.message);
      },
      (User _) {
        isRegisteringUser(false);
        if (isWalletConnect) {
          Get.toNamed<void>(AppRoutes.accountType);
        } else {
          Get.toNamed<void>(
            AppRoutes.otpVerifyEmail,
            arguments: const OTPVerificationScreenArgument(),
          );
        }
      },
    );
  }

  void createOkxAccount(BuildContext context, String? uname) async {
    isCreatingOkxAccount(true);

    final Either<Failure, OkxAccount> failureOrUser = await createSubAccount(
        CreateSubAccountRequest(subAccount: uname ?? username.value));

    failureOrUser.fold(
      (Failure failure) {
        isCreatingOkxAccount(false);
        AppSnacks.show(context, message: failure.message);
      },
      (OkxAccount _) {
        isCreatingOkxAccount(false);
        Get.toNamed<void>(
          AppRoutes.otpVerifyPhone,
          arguments: OTPVerificationScreenArgument(user: _.user),
        );
      },
    );
  }

  void updateRole(BuildContext context) async {
    isUpdatingUserRole(true);

    final Either<Failure, User> failureOrUser = await updateUserRole(
      UpdateUserRoleRequest(
        role: accountType.value == AccountType.personal ? 'user' : 'oddster',
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isUpdatingUserRole(false);
        AppSnacks.show(context, message: failure.message);
      },
      (_) {
        isUpdatingUserRole(false);
        Get.toNamed<void>(AppRoutes.personalInformation);
      },
    );
  }

  void updatePersonalInformation(BuildContext context) async {
    isAddingPersonalInformation(true);

    final Either<Failure, User> failureOrUser = await updateProfile(
      UpdateRequest(
        firstName: firstName.value,
        lastName: lastName.value,
        username: username.value,
        phone: phone.value,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isAddingPersonalInformation(false);
        AppSnacks.show(context, message: failure.message);
      },
      (User us) {
        isAddingPersonalInformation(false);
        baseScreenController.updateTheUser(us);

        createOkxAccount(context, us.username);
      },
    );
  }

  void onEmailInputChanged(String value) {
    email(value.trim());
  }

  void onReferralInputChanged(String value) {
    referralCode(value.trim());
  }

  void onUsernameInputChanged(String value) {
    username(value.trim());
  }

  void onFirstNameInputChanged(String value) {
    firstName(value.trim());
  }

  void onLastNameInputChanged(String value) {
    lastName(value.trim());
  }

  void onOkxUsernameInputChanged(String value) {
    okxUsername(value.trim());
  }

  void onDateOfBirthInputChanged(DateTime value) {
    dateOfBirth(value);
  }

  void onPhoneInputChanged(String value) {
    phone(value.trim());
  }

  void onPasswordInputChanged(String value) {
    password(value.trim());
  }

  void onConfirmPasswordInputChanged(String value) {
    confirmPassword(value.trim());
  }

  void onOTPCodeInputChanged(String value) {
    otpCode(value.trim());
  }

  void onIdentificationTypeInputChanged(String value) {
    identificationType(value);
  }

  void onIdentificationNumberInputChanged(String value) {
    identificationNumber(value.trim());
  }

  void onExpiryDateInputChanged(DateTime value) {
    expiryDate(value);
  }

  void onFileSelected(Uint8List? file) {
    docImage(file);
  }

  void onProfileImageSelected(Uint8List? file) {
    profileImage(file);
  }

  void onAccountTypeSelected(AccountType type) {
    accountType(type);
  }

  String? validateFirstName(String? firstName) {
    String? errorMessage;
    if (firstName!.isEmpty) {
      errorMessage = 'Please enter your first name.';
    }

    return errorMessage;
  }

  String? validateLastName(String? lastName) {
    String? errorMessage;
    if (lastName!.isEmpty) {
      errorMessage = 'Please enter your last name.';
    }
    return errorMessage;
  }

  String? validatePhone(String phone) {
    String? errorMessage;
    if (phone.isEmpty) {
      errorMessage = 'Please enter your phone number.';
    }
    return errorMessage;
  }

  String? validateLocation(String? location) {
    String? errorMessage;
    if (location!.isEmpty) {
      errorMessage = 'Please enter your location';
    }
    return errorMessage;
  }

  String? validateIdentificationNumber(String? idNumber) {
    String? errorMessage;
    if (idNumber!.isEmpty) {
      errorMessage = 'Please enter the identification number.';
    }
    return errorMessage;
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email address';
    } else if (!validator.isEmail(email.trim())) {
      errorMessage = 'Invalid email';
    }

    return errorMessage;
  }

  String? validateReferralCode(String? referralCode) {
    String? errorMessage;

    if (referralCode != null && referralCode.isNotEmpty) {
      if (referralCode.length != 7) {
        errorMessage = 'Referral code should be 7 digits';
      }
    }

    return errorMessage;
  }

  String? validateUsername(String? username) {
    String? errorMessage;
    if (username!.isEmpty) {
      errorMessage = 'Please enter username';
    }
    if (username.length < 3) {
      errorMessage = 'Username should be at least 3 characters';
    }
    return errorMessage;
  }

  String? validateOkxUsername(String? username) {
    String? errorMessage;
    if (username!.isEmpty) {
      errorMessage = 'Please enter username';
    }
    if (username.length < 6) {
      errorMessage = 'Username should be at least 6 characters';
    }
    return errorMessage;
  }

  String? validateMinimumAge({
    required DateTime dateOfBirth,
    required int minimumAge,
    String? errorMessage,
  }) {
    if ((DateTime.now().difference(dateOfBirth).inDays / 365).round() <
        minimumAge) {
      return errorMessage ?? 'You should be at least $minimumAge years old';
    }

    return null;
  }

  String? validateExpiryDate(DateTime? expiringDate) {
    if (expiringDate == null) {
      return 'Please select date';
    }
    if (expiringDate.isBefore(DateTime.now().add(const Duration(days: 30)))) {
      return 'Expiring date is too close';
    }
    return null;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  String? validateConfrimPassword(String? confirm) {
    String? errorMessage;
    if (confirm!.isEmpty) {
      errorMessage = 'Please confirm  password';
    } else if (password.value != confirmPassword.value) {
      errorMessage = 'Passwords do not match.';
    }

    return errorMessage;
  }

  bool get registrationFormIsValid =>
      validateEmail(email.value) == null &&
      validatePassword(password.value) == null &&
      validateConfrimPassword(confirmPassword.value) == null;

  bool get walletConnectRegistrationFormIsValid =>
      validatePassword(password.value) == null &&
      validateConfrimPassword(confirmPassword.value) == null;

  bool get profileFormIsValid => profileImage.value.isNotEmpty;

  bool get documentFormIsValid =>
      validateIdentificationNumber(identificationNumber.value) == null &&
      validateExpiryDate(expiryDate.value) == null &&
      docImage.value.isNotEmpty;

  bool get personalFormIsValid =>
      validateFirstName(firstName.value) == null &&
      validateLastName(lastName.value) == null &&
      validateUsername(username.value) == null &&
      validatePhone(phone.value) == null &&
      validateMinimumAge(dateOfBirth: dateOfBirth.value, minimumAge: 18) ==
          null;
}
