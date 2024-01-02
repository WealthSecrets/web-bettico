import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

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
    return AuthResponse.fromJson(json);
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
