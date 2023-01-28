import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';

abstract class OkxRemoteDataSources {
  Future<OkxAccount> createSubAccount(
      {required CreateSubAccountRequest request});
  Future<CreateDepositAddressResponse> createDepositAddress(
      {required CreateDepositAddressRequest request});
  Future<OkxAccount> getOkxAccount();
  Future<List<Currency>> fetchAssetCurrencies();
  Future<List<Deposit>> fetchDepositHistory();
  Future<List<Currency>> fetchConvertCurrencies();
}
