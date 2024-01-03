import 'dart:async';

import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';

abstract class AuthLocalDataSource {
  AuthResponse? get authResponse;
  Future<void> deleteAuthResponse();
  Future<AuthResponse?> getAuthResponse();
  Future<User?> getUserData();
  Future<void> persistAuthResponse(AuthResponse token);
  Future<void> persistUserData(User user);
  Future<bool> isAuthenticated();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._preferencesWrapper);
  final SharedPreferencesWrapper _preferencesWrapper;

  @override
  AuthResponse? authResponse;

  @override
  Future<void> deleteAuthResponse() async {
    await _preferencesWrapper.remove(SharedPrefsKeys.authResponse);
    await _preferencesWrapper.remove(SharedPrefsKeys.userData);
    authResponse = null;
  }

  @override
  Future<AuthResponse?> getAuthResponse() async {
    final Map<String, dynamic>? json = await _preferencesWrapper.getMap(SharedPrefsKeys.authResponse);
    if (json != null) {
      return authResponse = AuthResponse.fromJson(json);
    }
    return null;
  }

  @override
  Future<User?> getUserData() async {
    final Map<String, dynamic>? json = await _preferencesWrapper.getMap(SharedPrefsKeys.userData);
    if (json != null) {
      return User.fromJson(json);
    }
    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    final User? user = await getUserData();
    if (user != null && user.isVerified) {
      return true;
    }
    await deleteAuthResponse();
    return false;
  }

  @override
  Future<void> persistAuthResponse(AuthResponse response) async {
    authResponse = response;
    await _preferencesWrapper.setMap(
      SharedPrefsKeys.authResponse,
      response.toJson(),
    );
  }

  @override
  Future<void> persistUserData(User user) async {
    await _preferencesWrapper.setMap(
      SharedPrefsKeys.userData,
      user.toJson(),
    );
  }
}
