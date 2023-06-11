import 'package:betticos/features/advert/domain/repository/advert_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../../data/models/advert_model.dart';

class GetAllAdverts implements UseCase<List<Advert>, NoParams> {
  GetAllAdverts({required this.advertRepository});
  final AdvertRepository advertRepository;

  @override
  Future<Either<Failure, List<Advert>>> call(NoParams params) {
    return advertRepository.fetchAdverts();
  }
}
