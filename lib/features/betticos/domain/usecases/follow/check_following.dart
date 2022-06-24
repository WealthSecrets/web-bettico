import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/follow/follow_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '../../requests/follow/user_request.dart';

class CheckFollowing implements UseCase<Follow, UserRequest> {
  CheckFollowing({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Follow>> call(UserRequest params) {
    return betticosRepository.checkFollowing(userId: params.userId);
  }
}
