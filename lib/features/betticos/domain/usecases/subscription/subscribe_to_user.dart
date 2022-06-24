import 'package:betticos/features/betticos/data/models/subscription/subscription_model.dart';
import 'package:betticos/features/betticos/domain/requests/subscrbe/subscribe_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class SubscribeToUser implements UseCase<Subscription, SubscribeRequest> {
  SubscribeToUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Subscription>> call(SubscribeRequest params) {
    return betticosRepository.subscribeToUser(
      userId: params.userId,
    );
  }
}
