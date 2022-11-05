import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class GetPostIntroPrefs implements UseCase<bool?, NoParams> {
  GetPostIntroPrefs({required this.settingsRepository});
  SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, bool?>> call(NoParams params) {
    return settingsRepository.getPostIntroPrefs();
  }
}
