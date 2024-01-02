import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetReferralCode implements UseCase<User, NoParams> {
  GetReferralCode({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return betticosRepository.getReferralCode();
  }
}
