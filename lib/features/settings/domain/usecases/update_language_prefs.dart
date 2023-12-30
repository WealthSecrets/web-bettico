import 'package:betticos/core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/update_language.dart';
import '../repositories/settings_repository.dart';

class UpdateLanguagePrefs implements UseCase<void, UpdateLanguageRequest> {
  UpdateLanguagePrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, void>> call(UpdateLanguageRequest params) {
    return settingsRepository.updateLanguagePrefs(params.value);
  }
}
