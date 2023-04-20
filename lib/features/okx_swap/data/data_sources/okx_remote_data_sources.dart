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
