import 'package:betticos/features/okx_swap/data/endpoints/okx_endpoints.dart';
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

import '/core/utils/http_client.dart';
import 'okx_remote_data_sources.dart';

class OkxRemoteDataSourcesImpl implements OkxRemoteDataSources {
  const OkxRemoteDataSourcesImpl({required AppHTTPClient client})
      : _client = client;
  final AppHTTPClient _client;

  @override
  Future<OkxAccount> createSubAccount(
      {required CreateSubAccountRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      OkxEndpoints.subAccount,
      body: request.toJson(),
    );
    return OkxAccount.fromJson(json);
  }

  @override
  Future<OkxAccount> createSubAccountApiKey() async {
    final Map<String, dynamic> json = await _client.post(
      OkxEndpoints.subAccountApiKey,
      body: <String, dynamic>{},
    );
    return OkxAccount.fromJson(json);
  }

  @override
  Future<CurrencyPair> fetchCurrencyPair(
      {required CurrencyPairRequest request}) async {
    final Map<String, dynamic> json = await _client.get(
      OkxEndpoints.currencyPair(request.fromCurrency, request.toCurrency),
    );
    return CurrencyPair.fromJson(json);
  }

  @override
  Future<OkxQuote> estimateConversionQuote(
      {required QuoteRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      OkxEndpoints.estimateQuote,
      body: request.toJson(),
    );
    return OkxQuote.fromJson(json);
  }

  @override
  Future<ConversionResponse> convertTrade(
      {required ConversionRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      OkxEndpoints.convertTrade,
      body: request.toJson(),
    );
    return ConversionResponse.fromJson(json);
  }

  @override
  Future<CreateDepositAddressResponse> createDepositAddress(
      {required CreateDepositAddressRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      OkxEndpoints.depositAddress,
      body: request.toJson(),
    );
    return CreateDepositAddressResponse.fromJson(json);
  }

  @override
  Future<OkxAccount> getOkxAccount() async {
    final Map<String, dynamic> json =
        await _client.get(OkxEndpoints.okxAccount);
    return OkxAccount.fromJson(json);
  }

  @override
  Future<List<Currency>> fetchAssetCurrencies() async {
    final Map<String, dynamic> json =
        await _client.get(OkxEndpoints.assetCurrencies);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Currency>.from(
      items.map<Currency>(
          (dynamic json) => Currency.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<Deposit>> fetchDepositHistory() async {
    final Map<String, dynamic> json =
        await _client.get(OkxEndpoints.depositHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Deposit>.from(
      items.map<Deposit>(
          (dynamic json) => Deposit.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<OkxConversion>> fetchConversionHistory() async {
    final Map<String, dynamic> json =
        await _client.get(OkxEndpoints.convertHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<OkxConversion>.from(
      items.map<OkxConversion>((dynamic json) =>
          OkxConversion.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<Currency>> fetchConvertCurrencies() async {
    final Map<String, dynamic> json =
        await _client.get(OkxEndpoints.currencies);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Currency>.from(
      items.map<Currency>(
          (dynamic json) => Currency.fromJson(json as Map<String, dynamic>)),
    );
  }
}
