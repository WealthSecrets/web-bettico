import 'package:dartz/dartz.dart';

import '/core/core.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> updateIntroPrefs(bool value);
  Future<Either<Failure, void>> updatePostIntroPrefs(bool value);
  Future<Either<Failure, void>> updateLanguagePrefs(String value);
  Future<Either<Failure, bool?>> getIntroPrefs();
  Future<Either<Failure, bool?>> getPostIntroPrefs();
  Future<Either<Failure, String?>> getLanguagePrefs();
}
