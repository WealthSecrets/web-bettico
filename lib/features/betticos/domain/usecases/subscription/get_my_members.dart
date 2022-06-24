import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class GetMyMembers implements UseCase<List<User>, NoParams> {
  GetMyMembers({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return betticosRepository.getMyMembers();
  }
}
