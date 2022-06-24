import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';
import '/core/usecase/usecase.dart';
import '/features/onboarding_splash/domain/repositories/onboard_repository.dart';

class SaveOnBaord implements UseCase<void, NoParams> {
  SaveOnBaord({required this.onBoardRepository});

  OnBoardRepository onBoardRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return onBoardRepository.saveOnBoard(true);
  }
}
