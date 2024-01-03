import 'package:betticos/core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/update_intro.dart';
import '../repositories/settings_repository.dart';

class UpdateIntroPrefs implements UseCase<void, UpdateIntroRequest> {
  UpdateIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, void>> call(UpdateIntroRequest params) {
    return settingsRepository.updateIntroPrefs(params.value);
  }
}
