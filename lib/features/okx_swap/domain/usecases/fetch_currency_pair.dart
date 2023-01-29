import 'package:betticos/features/okx_swap/data/models/currency/currency_pair.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/currency_pair_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class FetchCurrencyPair implements UseCase<CurrencyPair, CurrencyPairRequest> {
  FetchCurrencyPair({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, CurrencyPair>> call(CurrencyPairRequest params) {
    return okxRepository.fetchCurrencyPair(
      fromCurrency: params.fromCurrency,
      toCurrency: params.toCurrency,
    );
  }
}
