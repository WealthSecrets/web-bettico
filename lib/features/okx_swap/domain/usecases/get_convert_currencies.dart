import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:dartz/dartz.dart';
import '/core/core.dart';

class GetConvertCurrencies implements UseCase<List<Currency>, NoParams> {
  GetConvertCurrencies({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, List<Currency>>> call(NoParams params) {
    return okxRepository.fetchConvertCurrencies();
  }
}
