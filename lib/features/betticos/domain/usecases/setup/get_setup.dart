import 'package:betticos/features/betticos/data/models/setup/setup_model.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';

class GetSetup implements UseCase<Setup, NoParams> {
  GetSetup({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Setup>> call(NoParams params) {
    return betticosRepository.getSetup();
  }
}
