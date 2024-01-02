import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetOkxAccount implements UseCase<OkxAccount, NoParams> {
  GetOkxAccount({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxAccount>> call(NoParams params) {
    return okxRepository.getOkxAccount();
  }
}
