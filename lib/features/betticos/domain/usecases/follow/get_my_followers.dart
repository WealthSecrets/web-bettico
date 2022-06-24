import 'package:betticos/features/betticos/domain/requests/follow/user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class GetMyFollowers implements UseCase<List<User>, UserRequest> {
  GetMyFollowers({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(UserRequest params) {
    return betticosRepository.getMyFollowers(params.userId);
  }
}
