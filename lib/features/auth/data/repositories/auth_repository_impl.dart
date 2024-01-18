import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends Repository implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, AuthResponse>> login(LoginRequest request) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.login(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response);
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> loginWallet(
    LoginWalletRequest request,
  ) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.loginWallet(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> verifyUser(VerifyUserRequest request) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.verifyUser(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final Either<Failure, void> response = await makeRequest(authRemoteDataSource.logout());
    return response.fold(left, (void _) async {
      await authLocalDataSource.deleteAuthResponse();
      return right(_);
    });
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    final Either<Failure, bool> response = await makeRequest(authLocalDataSource.isAuthenticated());
    return response.fold(left, right);
  }

  @override
  Future<Either<Failure, User>> forgotPassword(ForgotRequest request) async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.forgotPassword(request));
    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> register(RegisterRequest request) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.register(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> loadUser() async {
    final Either<Failure, User> response = await makeLocalRequest(authLocalDataSource.getUserData);
    return response.fold(left, (User user) async {
      return right(user);
    });
  }

  @override
  Future<Either<Failure, String>> loadToken() async {
    final Either<Failure, AuthResponse> response = await makeLocalRequest(authLocalDataSource.getAuthResponse);
    return response.fold(left, (AuthResponse response) async {
      return right(response.token);
    });
  }

  @override
  Future<Either<Failure, TwilioResponse>> sendSms(SendSmsRequest request) async {
    final Either<Failure, TwilioResponse> response = await makeRequest(authRemoteDataSource.sendSms(request));
    return response.fold(left, (TwilioResponse response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> verifySms(VerifySmsRequest request) async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.verifySms(request));
    return response.fold(left, (User response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> verifyEmail(VerifyEmailRequest request) async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.verifyEmail(request));
    return response.fold(left, (User response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> resendEmail(ResendEmailRequest request) async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.resendEmail(request));
    return response.fold(left, (User user) async {
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> updateUserIdentification({required IdentificationRequest request}) async {
    final Either<Failure, User> response = await makeRequest(
      authRemoteDataSource.updateUserIdentification(request: request),
    );
    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> updateUserProfilePhoto({
    required List<int> file,
    required Function(int count, int total) onSendProgress,
  }) async {
    final Either<Failure, User> response = await makeRequest(
      authRemoteDataSource.updateUserProfilePhoto(
        file: file,
      ),
    );

    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> resetPassword(ResetRequest request) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.resetPassword(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> updateMyPassword(UpdatePasswordRequest request) async {
    final Either<Failure, AuthResponse> response = await makeRequest(authRemoteDataSource.updateMyPassword(request));
    return response.fold(left, (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> updateProfile(UpdateRequest request) async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.updateProfile(request));
    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> updateUserRole(String role) async {
    final Either<Failure, User> response = await makeRequest(
      authRemoteDataSource.updateUserRole(
        UpdateUserRoleRequest(
          role: role,
        ),
      ),
    );
    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> validateSession() async {
    final Either<Failure, User> response = await makeRequest(authRemoteDataSource.validateSession());
    return response.fold(left, (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }
}
