import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchHashtags implements UseCase<List<Hashtag>, NoParams> {
  FetchHashtags({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, List<Hashtag>>> call(NoParams params) {
    return betticosRepository.fetchHashtags();
  }
}
