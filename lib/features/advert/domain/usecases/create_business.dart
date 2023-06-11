import 'package:betticos/features/advert/data/models/business_model.dart';
import 'package:betticos/features/advert/domain/repository/advert_repository.dart';
import 'package:betticos/features/advert/domain/requests/create_business_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class CreateBusiness implements UseCase<Business, CreateBusinessRequest> {
  CreateBusiness({required this.advertRepository});
  final AdvertRepository advertRepository;

  @override
  Future<Either<Failure, Business>> call(CreateBusinessRequest params) {
    return advertRepository.createBusiness(
      category: params.category,
      type: params.type,
      bio: params.bio,
      email: params.email,
      location: params.location,
      phone: params.phone,
      website: params.website,
    );
  }
}
