import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';
import '/core/usecase/usecase.dart';
import '/features/onboarding_splash/domain/repositories/onboard_repository.dart';

class GetOnBoard implements UseCase<bool, NoParams> {
  GetOnBoard({required this.onBoardRepository});

  OnBoardRepository onBoardRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return onBoardRepository.getOnBoard();
  }
}
