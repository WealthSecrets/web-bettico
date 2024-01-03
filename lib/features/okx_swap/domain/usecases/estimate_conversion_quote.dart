import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

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
