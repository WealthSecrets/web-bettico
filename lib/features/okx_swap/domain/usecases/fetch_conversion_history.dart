import 'package:betticos/features/okx_swap/data/models/convert/okx_conversion.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class FetchConversionHistory implements UseCase<List<OkxConversion>, NoParams> {
  FetchConversionHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<OkxConversion>>> call(NoParams params) {
    return okxRepository.fetchConversionHistory();
  }
}
