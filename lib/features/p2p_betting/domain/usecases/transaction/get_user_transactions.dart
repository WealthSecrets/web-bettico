import 'package:betticos/features/betticos/domain/requests/follow/user_request.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/p2p_betting/domain/repositories/p2p_repository.dart';

class GetUserTransactions implements UseCase<List<Transaction>, UserRequest> {
  GetUserTransactions({required this.p2prepository});
  final P2pRepository p2prepository;

  @override
  Future<Either<Failure, List<Transaction>>> call(UserRequest params) {
    return p2prepository.fetchMyTransactions(params.userId);
  }
}
