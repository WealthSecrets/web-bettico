import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FollowUser implements UseCase<Follow, UserRequest> {
  FollowUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Follow>> call(UserRequest params) {
    return betticosRepository.followUser(userId: params.userId);
  }
}
