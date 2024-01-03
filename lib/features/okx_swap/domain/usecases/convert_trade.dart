import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

class ConvertTrade implements UseCase<ConversionResponse, ConversionRequest> {
  ConvertTrade({required this.okxRepository});
  final OkxRepository okxRepository;

  @override
  Future<Either<Failure, ConversionResponse>> call(ConversionRequest params) {
    return okxRepository.convertTrade(
      baseCurrency: params.baseCurrency,
      quoteCurrency: params.quoteCurrency,
      realAmount: params.realAmount,
      realAmountCurrency: params.realAmountCurrency,
      side: params.side,
      quoteId: params.quoteId,
      clientOrderId: params.clientOrderId,
    );
  }
}
