import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/subscription/subscription_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/subscrbe/subscribe_request.dart';

class CheckSubscription implements UseCase<Subscription, SubscribeRequest> {
  CheckSubscription({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Subscription>> call(SubscribeRequest params) {
    return betticosRepository.checkSubscription(userId: params.userId);
  }
}
