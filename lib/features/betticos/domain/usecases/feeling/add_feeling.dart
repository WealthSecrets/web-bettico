import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '/features/betticos/data/models/feeling/feeling_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/feeling/feeling_request.dart';

class AddFeeling implements UseCase<Feeling, FeelingRequest> {
  AddFeeling({required this.betticosRepository});
  final BetticosRepository betticosRepository;

  @override
  Future<Either<Failure, Feeling>> call(FeelingRequest params) {
    return betticosRepository.addFeeling(
      postId: params.postId,
      type: params.type,
    );
  }
}
