import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/advert/data/models/business_model.dart';
import 'package:betticos/features/advert/presentation/getx/professional_controller.dart';
import 'package:betticos/features/advert/presentation/utils/business_category_type.dart';
import 'package:dartz/dartz.dart';

abstract class AdvertRepository {
  Future<Either<Failure, List<Advert>>> fetchAdverts();

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

  Future<Either<Failure, Business>> createBusiness({
    required BusinessCategoryType category,
    required BusinessType type,
    String? email,
    String? phone,
    String? location,
    String? bio,
    String? website,
  });
}
