import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class FetchCurrencyPair implements UseCase<CurrencyPair, CurrencyPairRequest> {
  FetchCurrencyPair({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, CurrencyPair>> call(CurrencyPairRequest params) {
    return okxRepository.fetchCurrencyPair(fromCurrency: params.fromCurrency, toCurrency: params.toCurrency);
  }
}
