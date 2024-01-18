import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> loginWallet(LoginWalletRequest request);
  Future<AuthResponse> verifyUser(VerifyUserRequest request);
  Future<User> forgotPassword(ForgotRequest request);
  Future<User> updateProfile(UpdateRequest request);
  Future<AuthResponse> resetPassword(ResetRequest request);
  Future<AuthResponse> updateMyPassword(UpdatePasswordRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<User> updateUserRole(UpdateUserRoleRequest request);
  Future<TwilioResponse> sendSms(SendSmsRequest request);
  Future<User> verifySms(VerifySmsRequest request);
  Future<User> verifyEmail(VerifyEmailRequest request);
  Future<User> resendEmail(ResendEmailRequest request);
  Future<User> updateUserIdentification({required IdentificationRequest request});
  Future<User> updateUserProfilePhoto({required List<int> file});

  Future<void> logout();
  Future<User> validateSession();
}
