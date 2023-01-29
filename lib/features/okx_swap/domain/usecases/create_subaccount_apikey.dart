import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class CreateSubAccountApiKey implements UseCase<OkxAccount, NoParams> {
  CreateSubAccountApiKey({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxAccount>> call(NoParams params) {
    return okxRepository.createSubAccountApiKey();
  }
}
