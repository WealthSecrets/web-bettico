import 'package:betticos/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class OnBoardRepository {
  Future<Either<Failure, void>> saveOnBoard(bool onboard);
  Future<Either<Failure, bool>> getOnBoard();
}
