import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetOnBoard implements UseCase<bool, NoParams> {
  GetOnBoard({required this.onBoardRepository});

  OnBoardRepository onBoardRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return onBoardRepository.getOnBoard();
  }
}
