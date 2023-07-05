import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/datasources/advert_remote_data_source.dart';
import 'package:betticos/features/advert/data/models/business_model.dart';
import 'package:betticos/features/advert/domain/requests/create_advert_request.dart';
import 'package:betticos/features/advert/domain/requests/create_business_request.dart';
import 'package:betticos/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/advert_repository.dart';
import '../../presentation/ads/getx/professional_controller.dart';
import '../../presentation/ads/utils/business_category_type.dart';
import '../models/advert_model.dart';

class AdvertRepositoryImpl extends Repository implements AdvertRepository {
  AdvertRepositoryImpl({required this.advertRemoteDataSource, required this.authLocalDataSource});

  final AdvertRemoteDataSource advertRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, List<Advert>>> fetchAdverts() => makeRequest(advertRemoteDataSource.fetchAdverts());

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

  @override
  Future<Either<Failure, Business>> createBusiness({
    required BusinessCategoryType category,
    required BusinessType type,
    String? email,
    String? phone,
    String? location,
    String? bio,
    String? website,
  }) async {
    final Either<Failure, Business> response = await makeRequest(
      advertRemoteDataSource.createBusiness(
        request: CreateBusinessRequest(
          category: category,
          type: type,
          email: email,
          phone: phone,
          location: location,
          bio: bio,
          website: website,
        ),
      ),
    );
    return response.fold(left, (Business business) async {
      await authLocalDataSource.persistUserData(business.user);
      return right(business);
    });
  }
}
