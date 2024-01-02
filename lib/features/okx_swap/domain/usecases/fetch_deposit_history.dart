import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchDepositHistory implements UseCase<List<Deposit>, NoParams> {
  FetchDepositHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Deposit>>> call(NoParams params) {
    return okxRepository.fetchDepositHistory();
  }
}
