import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../repositories/settings_repository.dart';

class GetIntroPrefs implements UseCase<bool?, NoParams> {
  GetIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, bool?>> call(NoParams params) {
    return settingsRepository.getIntroPrefs();
  }
}
