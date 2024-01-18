import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(LoginRequest request);
  Future<Either<Failure, AuthResponse>> loginWallet(LoginWalletRequest request);
  Future<Either<Failure, User>> verifyUser(VerifyUserRequest request);
  Future<Either<Failure, User>> forgotPassword(ForgotRequest request);
  Future<Either<Failure, User>> validateSession();
  Future<Either<Failure, User>> resetPassword(ResetRequest request);
  Future<Either<Failure, User>> updateMyPassword(UpdatePasswordRequest request);
  Future<Either<Failure, User>> updateProfile(UpdateRequest request);
  Future<Either<Failure, User>> updateUserRole(String role);
  Future<Either<Failure, AuthResponse>> register(RegisterRequest request);
  Future<Either<Failure, TwilioResponse>> sendSms(SendSmsRequest request);
  Future<Either<Failure, User>> verifySms(VerifySmsRequest request);
  Future<Either<Failure, User>> verifyEmail(VerifyEmailRequest request);
  Future<Either<Failure, User>> resendEmail(ResendEmailRequest request);
  Future<Either<Failure, User>> updateUserIdentification({
    required IdentificationRequest request,
  });
  Future<Either<Failure, User>> updateUserProfilePhoto({
    required Uint8List file,
    required Function(int count, int total) onSendProgress,
  });

  Future<Either<Failure, User>> loadUser();
  Future<Either<Failure, String>> loadToken();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
}
