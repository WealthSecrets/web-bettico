import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class CreateSubAccountApiKey implements UseCase<OkxAccount, NoParams> {
  CreateSubAccountApiKey({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxAccount>> call(NoParams params) {
    return okxRepository.createSubAccountApiKey();
  }
}
