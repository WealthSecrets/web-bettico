import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_update_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class UpdateTransaction
    implements UseCase<Transaction, TransactionUpdateRequest> {
  UpdateTransaction({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Transaction>> call(TransactionUpdateRequest params) {
    return p2prepository.updateTransaction(
        betId: params.betId, hash: params.hash ?? '');
  }
}
