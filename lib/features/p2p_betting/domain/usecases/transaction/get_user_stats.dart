import 'package:betticos/features/auth/data/models/user/user_stats.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class GetUserStats implements UseCase<UserStats?, NoParams> {
  GetUserStats({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, UserStats?>> call(NoParams params) {
    return p2prepository.getUserStats();
  }
}
