import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class GetLanguagePrefs implements UseCase<String?, NoParams> {
  GetLanguagePrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, String?>> call(NoParams params) {
    return settingsRepository.getLanguagePrefs();
  }
}
