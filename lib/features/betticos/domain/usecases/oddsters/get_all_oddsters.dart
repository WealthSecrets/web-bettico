import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetAllOddsters implements UseCase<List<User>, NoParams> {
  GetAllOddsters({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return betticosRepository.getAllOddsters();
  }
}
