import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class FetchHashtags implements UseCase<List<Hashtag>, NoParams> {
  FetchHashtags({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Hashtag>>> call(NoParams params) {
    return betticosRepository.fetchHashtags();
  }
}
