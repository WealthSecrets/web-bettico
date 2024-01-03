import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetListing implements UseCase<Listing, GetListingRequest> {
  GetListing({required this.repository});
  final BetticosRepository repository;

  @override
  Future<Either<Failure, Listing>> call(GetListingRequest params) {
    return repository.getListing(symbol: params.symbol);
  }
}
