import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/quote_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class EstimateConversionQuote implements UseCase<OkxQuote, QuoteRequest> {
  EstimateConversionQuote({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, OkxQuote>> call(QuoteRequest params) {
    return okxRepository.estimateConversionQuote(
      baseCurrency: params.baseCurrency,
      quoteCurrency: params.quoteCurrency,
      realAmount: params.realAmount,
      realAmountCurrency: params.realAmountCurrency,
      side: params.side,
    );
  }
}
