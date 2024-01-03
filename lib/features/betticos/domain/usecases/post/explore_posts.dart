import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ExplorePosts implements UseCase<PaginatedResponseData<Post>, PageParmas> {
  ExplorePosts({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, PaginatedResponseData<Post>>> call(PageParmas params) {
    return betticosRepository.explorePosts(params.page, params.size);
  }
}
