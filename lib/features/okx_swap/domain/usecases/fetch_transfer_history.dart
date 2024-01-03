import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchTransferHistory implements UseCase<List<TransferHistory>, NoParams> {
  FetchTransferHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<TransferHistory>>> call(NoParams params) {
    return okxRepository.fetchTransferHistory();
  }
}
