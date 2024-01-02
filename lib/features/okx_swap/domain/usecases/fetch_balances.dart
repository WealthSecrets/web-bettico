import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchBalances implements UseCase<BalanceResponse, NoParams> {
  FetchBalances({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, BalanceResponse>> call(NoParams params) {
    return okxRepository.fetchBalances();
  }
}
