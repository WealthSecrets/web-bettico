import 'package:betticos/core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/update_intro.dart';
import '../repositories/settings_repository.dart';

class UpdatePostIntroPrefs implements UseCase<void, UpdateIntroRequest> {
  UpdatePostIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, void>> call(UpdateIntroRequest params) {
    return settingsRepository.updatePostIntroPrefs(params.value);
  }
}
