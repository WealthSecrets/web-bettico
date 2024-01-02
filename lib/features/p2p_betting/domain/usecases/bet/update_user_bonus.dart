import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

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
