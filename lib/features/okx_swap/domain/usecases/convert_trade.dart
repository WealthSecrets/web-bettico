import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/conversion_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

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
