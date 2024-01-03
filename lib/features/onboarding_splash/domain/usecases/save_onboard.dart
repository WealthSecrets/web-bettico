import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class SaveOnBaord implements UseCase<void, NoParams> {
  SaveOnBaord({required this.onBoardRepository});

  OnBoardRepository onBoardRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return onBoardRepository.saveOnBoard(true);
  }
}
