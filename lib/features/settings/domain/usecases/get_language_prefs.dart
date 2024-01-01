import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../repositories/settings_repository.dart';

class GetLanguagePrefs implements UseCase<String?, NoParams> {
  GetLanguagePrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, String?>> call(NoParams params) {
    return settingsRepository.getLanguagePrefs();
  }
}
