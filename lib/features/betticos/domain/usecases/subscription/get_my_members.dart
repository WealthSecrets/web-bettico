import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetMyMembers implements UseCase<List<User>, NoParams> {
  GetMyMembers({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return betticosRepository.getMyMembers();
  }
}
