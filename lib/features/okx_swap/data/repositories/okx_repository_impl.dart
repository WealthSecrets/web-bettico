import 'package:betticos/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/conversion_response.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_conversion.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency_pair.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_request.dart';
import 'package:betticos/features/okx_swap/data/models/funds/subaccount_funds_response.dart';
import 'package:betticos/features/okx_swap/data/models/funds/transfer_history.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_history.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_request.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_response.dart';
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
    required this.authLocalDataSource,
  });

  final OkxRemoteDataSources okxRemoteDataSources;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, OkxAccount>> createSubAccount({required String subAccount}) async {
    final Either<Failure, OkxAccount> response = await makeRequest(
      okxRemoteDataSources.createSubAccount(
        request: CreateSubAccountRequest(subAccount: subAccount),
      ),
    );

    return response.fold((Failure failure) => left(failure), (OkxAccount account) async {
      await authLocalDataSource.persistUserData(account.user);
      return right(account);
    });
  }

  @override
  Future<Either<Failure, OkxAccount>> createSubAccountApiKey() async {
    final Either<Failure, OkxAccount> response = await makeRequest(okxRemoteDataSources.createSubAccountApiKey());
    return response.fold((Failure failure) => left(failure), (OkxAccount account) async {
      await authLocalDataSource.persistUserData(account.user);
      return right(account);
    });
  }

  @override
  Future<Either<Failure, CurrencyPair>> fetchCurrencyPair({required String fromCurrency, required String toCurrency}) =>
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
  Future<Either<Failure, WithdrawalResponse>> withdraw({
    required String fee,
    required String amount,
    required String currency,
    required String chain,
    required String toAddress,
    required String method,
  }) =>
      makeRequest(
        okxRemoteDataSources.withdraw(
          request: WithdrawalRequest(
            fee: fee,
            amount: amount,
            currency: currency,
            chain: chain,
            toAddress: toAddress,
            method: method,
          ),
        ),
      );

  @override
  Future<Either<Failure, SubAccountFundsResponse>> transferFundToSubAccount({
    required String from,
    required String amount,
    required String currency,
    required String to,
    required String subAccount,
  }) =>
      makeRequest(
        okxRemoteDataSources.transferFundToSubAccount(
          request: SubAccountFundsRequest(
            amount: amount,
            from: from,
            to: to,
            currency: currency,
            subAccount: subAccount,
          ),
        ),
      );

  @override
  Future<Either<Failure, List<WithdrawalHistory>>> fetchWithdrawalHistory() =>
      makeRequest(okxRemoteDataSources.fetchWithdrawalHistory());

  @override
  Future<Either<Failure, List<TransferHistory>>> fetchTransferHistory() =>
      makeRequest(okxRemoteDataSources.fetchTransferHistory());

  @override
  Future<Either<Failure, CreateDepositAddressResponse>> createDepositAddress(
          {required String currency, String? chain}) =>
      makeRequest(
        okxRemoteDataSources.createDepositAddress(
          request: CreateDepositAddressRequest(currency: currency, chain: chain),
        ),
      );

  @override
  Future<Either<Failure, OkxAccount>> getOkxAccount() async {
    final Either<Failure, OkxAccount> response = await makeRequest(okxRemoteDataSources.getOkxAccount());
    return response.fold((Failure failure) => left(failure), (OkxAccount account) async {
      await authLocalDataSource.persistUserData(account.user);
      return right(account);
    });
  }

  @override
  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies() =>
      makeRequest(okxRemoteDataSources.fetchAssetCurrencies());

  @override
  Future<Either<Failure, BalanceResponse>> fetchBalances() => makeRequest(okxRemoteDataSources.fetchBalances());

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
