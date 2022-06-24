import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:betticos/features/settings/domain/requests/update_language_request.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class UpdateLanguagePrefs implements UseCase<void, UpdateLanguageRequest> {
  UpdateLanguagePrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, void>> call(UpdateLanguageRequest params) {
    return settingsRepository.updateLanguagePrefs(params.value);
  }
}
