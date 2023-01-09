import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/domain/requests/transaction/transaction_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class AddTransaction implements UseCase<Transaction, TransactionRequest> {
  AddTransaction({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, Transaction>> call(TransactionRequest params) {
    return p2prepository.addTransaction(
      amount: params.amount,
      betId: params.betId,
      status: params.status,
      userId: params.userId,
      transactionHash: params.transactionHash,
      description: params.description,
      type: params.type,
      walletAddress: params.walletAddress,
      provider: params.provider,
      convertedAmount: params.convertedAmount,
      convertedToken: params.convertedToken,
      time: params.time,
      token: params.token,
      gas: params.gas,
    );
  }
}
