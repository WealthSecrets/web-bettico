import 'package:betticos/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class PageParmas {
  const PageParmas({
    required this.page,
    required this.size,
    required this.leagueId,
  });
  final int page;
  final int size;
  final int leagueId;
}

class SearchPageParams {
  const SearchPageParams({
    required this.keyword,
    required this.page,
    required this.size,
  });

  final String keyword;
  final int page;
  final int size;
}
