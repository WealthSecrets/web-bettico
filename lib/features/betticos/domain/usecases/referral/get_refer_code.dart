import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class GetReferralCode implements UseCase<User, NoParams> {
  GetReferralCode({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return betticosRepository.getReferralCode();
  }
}
