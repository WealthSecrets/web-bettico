import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetUserStats implements UseCase<UserStats?, NoParams> {
  GetUserStats({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, UserStats?>> call(NoParams params) {
    return p2prepository.getUserStats();
  }
}
