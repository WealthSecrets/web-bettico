import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';

abstract class OkxRemoteDataSources {
  Future<OkxAccount> createSubAccount(
      {required CreateSubAccountRequest request});
  Future<OkxAccount> getOkxAccount();
  Future<List<Currency>> fetchAssetCurrencies();
  Future<List<Currency>> fetchConvertCurrencies();
}
