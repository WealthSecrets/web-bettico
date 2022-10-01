import 'dart:io';

import 'package:betticos/features/auth/domain/requests/update_user_role/update_user_role_request.dart';
import 'package:betticos/features/auth/domain/requests/verify_user/verify_user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/data_sources/auth_local_data_source.dart';
import '/features/auth/data/data_sources/auth_remote_data_source.dart';
import '/features/auth/data/models/responses/auth_response/auth_response.dart';
import '/features/auth/data/models/responses/twilio/twilio_response.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
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

class AuthRepositoryImpl extends Repository implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, User>> login(LoginRequest request) async {
    final Either<Failure, AuthResponse> response =
        await makeRequest(authRemoteDataSource.login(request));
    return response.fold((Failure failure) => left(failure),
        (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> verifyUser(VerifyUserRequest request) async {
    final Either<Failure, AuthResponse> response =
        await makeRequest(authRemoteDataSource.verifyUser(request));
    return response.fold((Failure failure) => left(failure),
        (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final Either<Failure, void> response =
        await makeRequest(authRemoteDataSource.logout());
    return response.fold((Failure failure) => left(failure), (void _) async {
      await authLocalDataSource.deleteAuthResponse();
      return right(_);
    });
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    final Either<Failure, bool> response =
        await makeRequest(authLocalDataSource.isAuthenticated());
    return response.fold((Failure failure) => left(failure), (bool _) {
      return right(_);
    });
  }

  @override
  Future<Either<Failure, User>> forgotPassword(ForgotRequest request) async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.forgotPassword(request));
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> register(RegisterRequest request) async {
    final Either<Failure, AuthResponse> response =
        await makeRequest(authRemoteDataSource.register(request));
    return response.fold((Failure failure) => left(failure),
        (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> loadUser() async {
    final Either<Failure, User> response =
        await makeLocalRequest(authLocalDataSource.getUserData);
    return response.fold((Failure failure) => left(failure), (User user) async {
      return right(user);
    });
  }

  @override
  Future<Either<Failure, String>> loadToken() async {
    final Either<Failure, AuthResponse> response =
        await makeLocalRequest(authLocalDataSource.getAuthResponse);
    return response.fold((Failure failure) => left(failure),
        (AuthResponse response) async {
      return right(response.token);
    });
  }

  @override
  Future<Either<Failure, TwilioResponse>> sendSms(
      SendSmsRequest request) async {
    final Either<Failure, TwilioResponse> response =
        await makeRequest(authRemoteDataSource.sendSms(request));
    return response.fold((Failure failure) => left(failure),
        (TwilioResponse response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> verifySms(VerifySmsRequest request) async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.verifySms(request));
    return response.fold((Failure failure) => left(failure),
        (User response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> verifyEmail(VerifyEmailRequest request) async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.verifyEmail(request));
    return response.fold((Failure failure) => left(failure),
        (User response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, User>> resendEmail(ResendEmailRequest request) async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.resendEmail(request));
    return response.fold((Failure failure) => left(failure), (User user) async {
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> updateUserIdentification({
    required File file,
    required IdentificationRequest request,
    required Function(int count, int total) onSendProgress,
  }) async {
    final Either<Failure, User> response = await makeRequest(
      authRemoteDataSource.updateUserIdentification(
        file: FormUploadDocument(field: 'file', file: file),
        request: request,
        onSendProgress: onSendProgress,
      ),
    );
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> updateUserProfilePhoto({
    required File file,
    required Function(int count, int total) onSendProgress,
  }) async {
    final Either<Failure, User> response = await makeRequest(
      authRemoteDataSource.updateUserProfilePhoto(
        file: FormUploadDocument(field: 'file', file: file),
        onSendProgress: onSendProgress,
      ),
    );

    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> resetPassword(ResetRequest request) async {
    final Either<Failure, AuthResponse> response =
        await makeRequest(authRemoteDataSource.resetPassword(request));
    return response.fold((Failure failure) => left(failure),
        (AuthResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      await authLocalDataSource.persistUserData(response.user);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> updateProfile(UpdateRequest request) async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.updateProfile(request));
    return response.fold((Failure failure) => left(failure), (User user) async {
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
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> validateSession() async {
    final Either<Failure, User> response =
        await makeRequest(authRemoteDataSource.validateSession());
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }
}
