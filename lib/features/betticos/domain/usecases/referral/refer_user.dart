import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/referral/referral_request.dart';

class ReferUser implements UseCase<void, ReferralRequest> {
  ReferUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, void>> call(ReferralRequest params) {
    return betticosRepository.referUser(
      email: params.email,
    );
  }
}
