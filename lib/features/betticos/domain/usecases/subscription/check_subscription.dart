import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class CheckSubscription implements UseCase<Subscription, SubscribeRequest> {
  CheckSubscription({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Subscription>> call(SubscribeRequest params) {
    return betticosRepository.checkSubscription(userId: params.userId);
  }
}
