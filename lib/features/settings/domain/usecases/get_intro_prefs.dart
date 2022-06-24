import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class GetIntroPrefs implements UseCase<bool?, NoParams> {
  GetIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, bool?>> call(NoParams params) {
    return settingsRepository.getIntroPrefs();
  }
}
