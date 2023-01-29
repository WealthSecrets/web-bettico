import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_conversion.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency_pair.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';

abstract class OkxRepository {
  Future<Either<Failure, OkxAccount>> createSubAccount(
      {required String subAccount});

  Future<Either<Failure, CurrencyPair>> fetchCurrencyPair(
      {required String fromCurrency, required String toCurrency});

  Future<Either<Failure, OkxQuote>> estimateConversionQuote({
    required String baseCurrency,
    required String quoteCurrency,
    required String side,
    required String realAmount,
    required String realAmountCurrency,
  });

  Future<Either<Failure, ConversionResponse>> convertTrade({
    required String baseCurrency,
    required String quoteCurrency,
    required String side,
    required String realAmount,
    required String realAmountCurrency,
    required String quoteId,
    required String clientOrderId,
  });

  Future<Either<Failure, CreateDepositAddressResponse>> createDepositAddress(
      {required String currency, String? chain});

  Future<Either<Failure, OkxAccount>> getOkxAccount();

  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies();

  Future<Either<Failure, List<Deposit>>> fetchDepositHistory();

  Future<Either<Failure, List<OkxConversion>>> fetchConversionHistory();

  Future<Either<Failure, List<Currency>>> fetchConvertCurrencies();
}
