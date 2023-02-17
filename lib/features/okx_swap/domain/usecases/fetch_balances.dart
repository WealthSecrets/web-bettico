import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchBalances implements UseCase<List<BalanceResponse>, NoParams> {
  FetchBalances({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<BalanceResponse>>> call(NoParams params) {
    return okxRepository.fetchBalances();
  }
}
