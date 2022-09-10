import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/p2p_betting/domain/requests/bet/user_bonus_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class UpdateUserBonus implements UseCase<User, UserBonusRequest> {
  UpdateUserBonus({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, User>> call(UserBonusRequest params) {
    return p2prepository.updateUserBonus(
      amount: params.amount,
      type: params.type,
    );
  }
}
