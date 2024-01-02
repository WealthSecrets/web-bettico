import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class SearchAllOddsters implements UseCase<List<User>, SearchUserRequest> {
  SearchAllOddsters({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(SearchUserRequest params) {
    return betticosRepository.searchAllOddsters(params.query);
  }
}
