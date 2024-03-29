import 'dart:async';
import '/core/utils/utils.dart';

abstract class SettingsLocalDataSource {
  Future<void> updateIntroPrefs(bool value);
  Future<void> updatePostIntroPrefs(bool value);
  Future<bool?> getIntroPrefs();
  Future<bool?> getPostIntroPrefs();
  Future<void> updateLanguagePrefs(String value);
  Future<String?> getLanguagePrefs();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._preferencesWrapper);
  final SharedPreferencesWrapper _preferencesWrapper;

  @override
  Future<void> updateIntroPrefs(bool value) async {
    await _preferencesWrapper.setBool(
      SharedPrefsKeys.intro,
      value,
    );
  }

  @override
  Future<void> updatePostIntroPrefs(bool value) async {
    await _preferencesWrapper.setBool(
      SharedPrefsKeys.postIntro,
      value,
    );
  }

  @override
  Future<bool?> getIntroPrefs() async {
    final bool? value = await _preferencesWrapper.getBool(SharedPrefsKeys.intro);
    return value;
  }

  @override
  Future<bool?> getPostIntroPrefs() async {
    final bool? value = await _preferencesWrapper.getBool(SharedPrefsKeys.postIntro);
    return value;
  }

  @override
  Future<void> updateLanguagePrefs(String value) async {
    await _preferencesWrapper.setString(
      SharedPrefsKeys.language,
      value,
    );
  }

  @override
  Future<String?> getLanguagePrefs() async {
    final String value = await _preferencesWrapper.getString(SharedPrefsKeys.language);
    return value;
  }
}
