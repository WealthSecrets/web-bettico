import 'package:betticos/features/betticos/domain/requests/user/search_user_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class SearchAllOddsters implements UseCase<List<User>, SearchUserRequest> {
  SearchAllOddsters({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<User>>> call(SearchUserRequest params) {
    return betticosRepository.searchAllOddsters(params.query);
  }
}
