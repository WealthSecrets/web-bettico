import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchConversionHistory implements UseCase<List<OkxConversion>, NoParams> {
  FetchConversionHistory({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<OkxConversion>>> call(NoParams params) {
    return okxRepository.fetchConversionHistory();
  }
}
