import 'package:betticos/features/okx_swap/data/models/funds/transfer_history.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchTransferHistory implements UseCase<List<TransferHistory>, NoParams> {
  FetchTransferHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<TransferHistory>>> call(NoParams params) {
    return okxRepository.fetchTransferHistory();
  }
}
