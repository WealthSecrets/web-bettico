import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:betticos/features/settings/domain/requests/update_intro_request.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class UpdateIntroPrefs implements UseCase<void, UpdateIntroRequest> {
  UpdateIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, void>> call(UpdateIntroRequest params) {
    return settingsRepository.updateIntroPrefs(params.value);
  }
}
