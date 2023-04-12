import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/domain/repositories/betticos_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class FetchListings implements UseCase<List<Listing>, NoParams> {
  FetchListings({required this.repository});
  final BetticosRepository repository;

  @override
  Future<Either<Failure, List<Listing>>> call(NoParams params) {
    return repository.fetchListings();
  }
}
