import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/advert/domain/repository/advert_repository.dart';
import 'package:betticos/features/advert/domain/requests/create_advert_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class CreateAdvert implements UseCase<Advert, CreateAdvertRequest> {
  CreateAdvert({required this.advertRepository});
  final AdvertRepository advertRepository;

  @override
  Future<Either<Failure, Advert>> call(CreateAdvertRequest params) {
    return advertRepository.createAdvert(
      ageRange: params.ageRange,
      budget: params.budget,
      category: params.category,
      gender: params.gender,
      location: params.location,
      post: params.post,
      target: params.target,
      duration: params.duration,
    );
  }
}
