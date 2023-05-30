import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/datasources/advert_remote_data_source.dart';
import 'package:betticos/features/advert/domain/requests/create_advert_request.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/advert_repository.dart';
import '../models/advert_model.dart';

class AdvertRepositoryImpl extends Repository implements AdvertRepository {
  AdvertRepositoryImpl({required this.advertRemoteDataSource});

  final AdvertRemoteDataSource advertRemoteDataSource;

  @override
  Future<Either<Failure, Advert>> createAdvert({
    required String post,
    required Gender gender,
    required Category category,
    required Target target,
    required int budget,
    required String location,
    required AgeRange ageRange,
    required int duration,
  }) =>
      makeRequest(
        advertRemoteDataSource.createAdvert(
          request: CreateAdvertRequest(
            post: post,
            category: category,
            target: target,
            gender: gender,
            budget: budget,
            location: location,
            ageRange: ageRange,
            duration: duration,
          ),
        ),
      );
}
