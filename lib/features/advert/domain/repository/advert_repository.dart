import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:dartz/dartz.dart';

abstract class AdvertRepository {
  Future<Either<Failure, Advert>> createAdvert({
    required String post,
    required Gender gender,
    required Category category,
    required Target target,
    required int budget,
    required String location,
    required AgeRange ageRange,
    required int duration,
  });
}
