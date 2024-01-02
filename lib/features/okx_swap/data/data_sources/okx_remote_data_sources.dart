import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

abstract class OkxRemoteDataSources {
  Future<OkxAccount> createSubAccount({required CreateSubAccountRequest request});
  Future<OkxAccount> createSubAccountApiKey();
  Future<CurrencyPair> fetchCurrencyPair({required CurrencyPairRequest request});
  Future<OkxQuote> estimateConversionQuote({required QuoteRequest request});
  Future<ConversionResponse> convertTrade({required ConversionRequest request});
  Future<WithdrawalResponse> withdraw({required WithdrawalRequest request});
  Future<SubAccountFundsResponse> transferFundToSubAccount({required SubAccountFundsRequest request});
  Future<CreateDepositAddressResponse> createDepositAddress({required CreateDepositAddressRequest request});
  Future<OkxAccount> getOkxAccount();
  Future<List<Currency>> fetchAssetCurrencies();
  Future<BalanceResponse> fetchBalances();
  Future<List<Deposit>> fetchDepositHistory();
  Future<List<OkxConversion>> fetchConversionHistory();
  Future<List<WithdrawalHistory>> fetchWithdrawalHistory();
  Future<List<TransferHistory>> fetchTransferHistory();
  Future<List<Currency>> fetchConvertCurrencies();
}
