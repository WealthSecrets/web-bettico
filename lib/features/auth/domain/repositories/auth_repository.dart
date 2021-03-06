import 'dart:io';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/responses/twilio/twilio_response.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/requests/forgot_request/forgot_request.dart';
import '/features/auth/domain/requests/identification/identification_request.dart';
import '/features/auth/domain/requests/login_request/login_request.dart';
import '/features/auth/domain/requests/register_request/register_request.dart';
import '/features/auth/domain/requests/resend_email/resend_email_request.dart';
import '/features/auth/domain/requests/reset_request/reset_request.dart';
import '/features/auth/domain/requests/sms/send_sms_request.dart';
import '/features/auth/domain/requests/verify_email/verify_email_request.dart';
import '/features/auth/domain/requests/verify_sms/verify_sms_request.dart';
import '/features/betticos/domain/requests/update_request/update_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginRequest request);
  Future<Either<Failure, User>> verifyUser(VerifyUserRequest request);
  Future<Either<Failure, User>> forgotPassword(ForgotRequest request);
  Future<Either<Failure, User>> validateSession();
  Future<Either<Failure, User>> resetPassword(ResetRequest request);
  Future<Either<Failure, User>> updateProfile(UpdateRequest request);
  Future<Either<Failure, User>> updateUserRole(String role);
  Future<Either<Failure, User>> register(RegisterRequest request);
  Future<Either<Failure, TwilioResponse>> sendSms(SendSmsRequest request);
  Future<Either<Failure, User>> verifySms(VerifySmsRequest request);
  Future<Either<Failure, User>> verifyEmail(VerifyEmailRequest request);
  Future<Either<Failure, User>> resendEmail(ResendEmailRequest request);
  Future<Either<Failure, User>> updateUserIdentification({
    required File file,
    required IdentificationRequest request,
    required Function(int count, int total) onSendProgress,
  });
  Future<Either<Failure, User>> updateUserProfilePhoto({
    required File file,
    required Function(int count, int total) onSendProgress,
  });

  Future<Either<Failure, User>> loadUser();
  Future<Either<Failure, String>> loadToken();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
}
