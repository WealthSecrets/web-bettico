import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

class OkxRemoteDataSourcesImpl implements OkxRemoteDataSources {
  const OkxRemoteDataSourcesImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<OkxAccount> createSubAccount({required CreateSubAccountRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.subAccount, body: request.toJson());
    return OkxAccount.fromJson(json);
  }

  @override
  Future<OkxAccount> createSubAccountApiKey() async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.subAccountApiKey, body: <String, dynamic>{});
    return OkxAccount.fromJson(json);
  }

  @override
  Future<CurrencyPair> fetchCurrencyPair({required CurrencyPairRequest request}) async {
    final Map<String, dynamic> json = await _client.get(
      OkxEndpoints.currencyPair(request.fromCurrency, request.toCurrency),
    );
    return CurrencyPair.fromJson(json);
  }

  @override
  Future<OkxQuote> estimateConversionQuote({required QuoteRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.estimateQuote, body: request.toJson());
    return OkxQuote.fromJson(json);
  }

  @override
  Future<ConversionResponse> convertTrade({required ConversionRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.convertTrade, body: request.toJson());
    return ConversionResponse.fromJson(json);
  }

  @override
  Future<WithdrawalResponse> withdraw({required WithdrawalRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.withdrawal, body: request.toJson());
    return WithdrawalResponse.fromJson(json);
  }

  @override
  Future<SubAccountFundsResponse> transferFundToSubAccount({required SubAccountFundsRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.transferFunds, body: request.toJson());
    return SubAccountFundsResponse.fromJson(json);
  }

  @override
  Future<CreateDepositAddressResponse> createDepositAddress({required CreateDepositAddressRequest request}) async {
    final Map<String, dynamic> json = await _client.post(OkxEndpoints.depositAddress, body: request.toJson());
    return CreateDepositAddressResponse.fromJson(json);
  }

  @override
  Future<OkxAccount> getOkxAccount() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.okxAccount);
    return OkxAccount.fromJson(json);
  }

  @override
  Future<List<Currency>> fetchAssetCurrencies() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.assetCurrencies);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Currency>.from(items.map<Currency>((dynamic json) => Currency.fromJson(json as Map<String, dynamic>)));
  }

  @override
  Future<List<Deposit>> fetchDepositHistory() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.depositHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Deposit>.from(items.map<Deposit>((dynamic json) => Deposit.fromJson(json as Map<String, dynamic>)));
  }

  @override
  Future<List<OkxConversion>> fetchConversionHistory() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.convertHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<OkxConversion>.from(
      items.map<OkxConversion>((dynamic json) => OkxConversion.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<WithdrawalHistory>> fetchWithdrawalHistory() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.withdrawalHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<WithdrawalHistory>.from(
      items.map<WithdrawalHistory>((dynamic json) => WithdrawalHistory.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<TransferHistory>> fetchTransferHistory() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.transferHistory);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<TransferHistory>.from(
      items.map<TransferHistory>((dynamic json) => TransferHistory.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<List<Currency>> fetchConvertCurrencies() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.currencies);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Currency>.from(items.map<Currency>((dynamic json) => Currency.fromJson(json as Map<String, dynamic>)));
  }

  @override
  Future<BalanceResponse> fetchBalances() async {
    final Map<String, dynamic> json = await _client.get(OkxEndpoints.balances);
    return BalanceResponse.fromJson(json);
  }
}
