import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class BlockUser implements UseCase<User, UserRequest> {
  BlockUser({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, User>> call(UserRequest params) {
    return betticosRepository.blockUser(
      userId: params.userId,
    );
  }
}
