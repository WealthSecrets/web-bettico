import 'package:betticos/features/auth/domain/requests/resend_email/resend_email_request.dart';
import 'package:betticos/features/auth/domain/requests/update_user_role/update_user_role_request.dart';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';
import '/features/auth/data/models/responses/auth_response/auth_response.dart';
import '/features/auth/data/models/responses/twilio/twilio_response.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/requests/forgot_request/forgot_request.dart';
import '/features/auth/domain/requests/identification/identification_request.dart';
import '/features/auth/domain/requests/login_request/login_request.dart';
import '/features/auth/domain/requests/register_request/register_request.dart';
import '/features/auth/domain/requests/reset_request/reset_request.dart';
import '/features/auth/domain/requests/sms/send_sms_request.dart';
import '/features/auth/domain/requests/verify_email/verify_email_request.dart';
import '/features/auth/domain/requests/verify_sms/verify_sms_request.dart';
import '/features/betticos/domain/requests/update_request/update_request.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> verifyUser(VerifyUserRequest request);
  Future<User> forgotPassword(ForgotRequest request);
  Future<User> updateProfile(UpdateRequest request);
  Future<AuthResponse> resetPassword(ResetRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<User> updateUserRole(UpdateUserRoleRequest request);
  Future<TwilioResponse> sendSms(SendSmsRequest request);
  Future<User> verifySms(VerifySmsRequest request);
  Future<User> verifyEmail(VerifyEmailRequest request);
  Future<User> resendEmail(ResendEmailRequest request);
  Future<User> updateUserIdentification({
    required IdentificationRequest request,
  });
  Future<User> updateUserProfilePhoto({required List<int> file});

  Future<void> logout();
  Future<User> validateSession();
}
