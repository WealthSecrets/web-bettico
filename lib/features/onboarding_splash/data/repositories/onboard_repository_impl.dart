import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/onboarding_splash/data/data_sources/onboard_local_data_source.dart';
import '/features/onboarding_splash/domain/repositories/onboard_repository.dart';

class OnBoardRepositoryImpl extends Repository implements OnBoardRepository {
  OnBoardRepositoryImpl({
    required this.onBoardLocalDataSource,
  });

  final OnBoardLocalDataSource onBoardLocalDataSource;

  @override
  Future<Either<Failure, bool>> getOnBoard() async {
    final Either<Failure, bool> response = await makeLocalRequest(onBoardLocalDataSource.getOnBoard);
    return response.fold(left, (bool value) async {
      return right(value);
    });
  }

  @override
  Future<Either<Failure, void>> saveOnBoard(bool onboard) async {
    final void value = await onBoardLocalDataSource.saveOnBoard(onboard);
    return right(value);
  }
}
