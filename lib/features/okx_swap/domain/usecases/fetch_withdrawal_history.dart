import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_history.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchWithdrawalHistory implements UseCase<List<WithdrawalHistory>, NoParams> {
  FetchWithdrawalHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<WithdrawalHistory>>> call(NoParams params) {
    return okxRepository.fetchWithdrawalHistory();
  }
}
