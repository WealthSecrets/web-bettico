import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ReferUser implements UseCase<void, ReferralRequest> {
  ReferUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(ReferralRequest params) {
    return betticosRepository.referUser(email: params.email);
  }
}
