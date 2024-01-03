import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchSubscribedOddboxes implements UseCase<List<Post>, NoParams> {
  FetchSubscribedOddboxes({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return betticosRepository.fetchSubscribedOddbox();
  }
}
