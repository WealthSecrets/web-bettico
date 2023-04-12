import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/domain/repositories/betticos_repository.dart';
import 'package:betticos/features/betticos/domain/requests/listing/get_listing_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class GetListing implements UseCase<Listing, GetListingRequest> {
  GetListing({required this.repository});
  final BetticosRepository repository;

  @override
  Future<Either<Failure, Listing>> call(GetListingRequest params) {
    return repository.getListing(symbol: params.symbol);
  }
}
