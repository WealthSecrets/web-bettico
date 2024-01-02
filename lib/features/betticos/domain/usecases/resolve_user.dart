import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ResolveUser implements UseCase<User, ResolveUserRequest> {
  ResolveUser({required this.betticosRepository});
  BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(ResolveUserRequest params) {
    return betticosRepository.resolveUser(userId: params.userId);
  }
}
