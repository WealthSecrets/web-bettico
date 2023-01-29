import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchDepositHistory implements UseCase<List<Deposit>, NoParams> {
  FetchDepositHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Deposit>>> call(NoParams params) {
    return okxRepository.fetchDepositHistory();
  }
}
