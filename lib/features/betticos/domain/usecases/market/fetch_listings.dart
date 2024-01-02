import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchListings implements UseCase<List<Listing>, NoParams> {
  FetchListings({required this.repository});
  final BetticosRepository repository;

  @override
  Future<Either<Failure, List<Listing>>> call(NoParams params) {
    return repository.fetchListings();
  }
}
