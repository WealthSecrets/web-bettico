import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources.dart';
import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_conversion.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency_pair.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/conversion_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/currency_pair_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/conversion/quote_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../../domain/repositories/okx_repository.dart';

class OkxRepositoryImpl extends Repository implements OkxRepository {
  OkxRepositoryImpl({
    required this.okxRemoteDataSources,
  });

  final OkxRemoteDataSources okxRemoteDataSources;

  @override
  Future<Either<Failure, OkxAccount>> createSubAccount(
          {required String subAccount}) =>
      makeRequest(
        okxRemoteDataSources.createSubAccount(
          request: CreateSubAccountRequest(subAccount: subAccount),
        ),
      );

  @override
  Future<Either<Failure, OkxAccount>> createSubAccountApiKey() => makeRequest(
        okxRemoteDataSources.createSubAccountApiKey(),
      );

  @override
  Future<Either<Failure, CurrencyPair>> fetchCurrencyPair(
          {required String fromCurrency, required String toCurrency}) =>
      makeRequest(
        okxRemoteDataSources.fetchCurrencyPair(
          request: CurrencyPairRequest(
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
          ),
        ),
      );

  @override
  Future<Either<Failure, OkxQuote>> estimateConversionQuote({
    required String baseCurrency,
    required String quoteCurrency,
    required String side,
    required String realAmount,
    required String realAmountCurrency,
  }) =>
      makeRequest(
        okxRemoteDataSources.estimateConversionQuote(
          request: QuoteRequest(
            baseCurrency: baseCurrency,
            quoteCurrency: quoteCurrency,
            side: side,
            realAmount: realAmount,
            realAmountCurrency: realAmountCurrency,
          ),
        ),
      );

  @override
  Future<Either<Failure, ConversionResponse>> convertTrade({
    required String baseCurrency,
    required String quoteCurrency,
    required String side,
    required String realAmount,
    required String realAmountCurrency,
    required String quoteId,
    required String clientOrderId,
  }) =>
      makeRequest(
        okxRemoteDataSources.convertTrade(
          request: ConversionRequest(
            baseCurrency: baseCurrency,
            quoteCurrency: quoteCurrency,
            side: side,
            realAmount: realAmount,
            realAmountCurrency: realAmountCurrency,
            quoteId: quoteId,
            clientOrderId: clientOrderId,
          ),
        ),
      );

  @override
  Future<Either<Failure, CreateDepositAddressResponse>> createDepositAddress(
          {required String currency, String? chain}) =>
      makeRequest(
        okxRemoteDataSources.createDepositAddress(
          request:
              CreateDepositAddressRequest(currency: currency, chain: chain),
        ),
      );

  @override
  Future<Either<Failure, OkxAccount>> getOkxAccount() =>
      makeRequest(okxRemoteDataSources.getOkxAccount());

  @override
  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies() =>
      makeRequest(okxRemoteDataSources.fetchAssetCurrencies());

  @override
  Future<Either<Failure, List<Deposit>>> fetchDepositHistory() =>
      makeRequest(okxRemoteDataSources.fetchDepositHistory());

  @override
  Future<Either<Failure, List<OkxConversion>>> fetchConversionHistory() =>
      makeRequest(okxRemoteDataSources.fetchConversionHistory());

  @override
  Future<Either<Failure, List<Currency>>> fetchConvertCurrencies() =>
      makeRequest(okxRemoteDataSources.fetchAssetCurrencies());
}
