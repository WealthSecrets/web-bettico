import 'package:betticos/features/auth/domain/requests/login_wallet_request/login_wallet_request.dart';
import 'package:betticos/features/auth/domain/requests/resend_email/resend_email_request.dart';
import 'package:betticos/features/auth/domain/requests/update_user_role/update_user_role_request.dart';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';

import '/core/core.dart';
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
import '/features/betticos/data/data_sources/betticos_endpoints.dart';
import '/features/betticos/domain/requests/update_request/update_request.dart';
import 'auth_endpoints.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signin,
      body: request.toJson(),
    );
    return AuthResponse.fromJson(json);
  }

  @override
  Future<AuthResponse> loginWallet(LoginWalletRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signinWallet,
      body: request.toJson(),
    );
    final AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }

  @override
  Future<void> logout() async {
    await _client.get(AuthEndpoints.signout);
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signup,
      body: request.toJson(),
    );
    final AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }

  @override
  Future<User> validateSession() async {
    final Map<String, dynamic> json = await _client.get(AuthEndpoints.validate);
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> verifySms(VerifySmsRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.verifySms,
      body: request.toJson(),
    );

    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> verifyEmail(VerifyEmailRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.verifyEmail,
      body: request.toJson(),
    );

    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<AuthResponse> verifyUser(VerifyUserRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.verifyUser,
      body: request.toJson(),
    );
    final AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }

  @override
  Future<User> resendEmail(ResendEmailRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.resendEmail,
      body: request.toJson(),
    );

    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> updateUserRole(UpdateUserRoleRequest request) async {
    final Map<String, dynamic> json = await _client.patch(
      AuthEndpoints.updateMe,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<TwilioResponse> sendSms(SendSmsRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.sendSms,
      body: request.toJson(),
    );
    return TwilioResponse.fromJson(json);
  }

  @override
  Future<User> updateUserIdentification({
    required IdentificationRequest request,
  }) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.identification,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> updateUserProfilePhoto({required List<int> file}) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.updatePhoto,
      body: <String, dynamic>{'file': file},
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> forgotPassword(ForgotRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.forgot,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<AuthResponse> resetPassword(ResetRequest request) async {
    final Map<String, dynamic> json = await _client.patch(
      BetticosEndpoints.resetPassword,
      body: request.toJson(),
    );
    final AuthResponse resetResponse = AuthResponse.fromJson(json);
    return resetResponse;
  }

  @override
  Future<User> updateProfile(UpdateRequest request) async {
    final Map<String, dynamic> json = await _client.patch(
      AuthEndpoints.updateMe,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }
}
