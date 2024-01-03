import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchWithdrawalHistory implements UseCase<List<WithdrawalHistory>, NoParams> {
  FetchWithdrawalHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<WithdrawalHistory>>> call(NoParams params) {
    return okxRepository.fetchWithdrawalHistory();
  }
}
