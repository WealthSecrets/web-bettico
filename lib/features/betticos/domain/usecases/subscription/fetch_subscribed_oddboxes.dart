import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class FetchSubscribedOddboxes implements UseCase<List<Post>, NoParams> {
  FetchSubscribedOddboxes({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return betticosRepository.fetchSubscribedOddbox();
  }
}
