import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class GetConvertCurrencies implements UseCase<List<Currency>, NoParams> {
  GetConvertCurrencies({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Currency>>> call(NoParams params) {
    return okxRepository.fetchConvertCurrencies();
  }
}
