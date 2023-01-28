import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';

abstract class OkxRepository {
  Future<Either<Failure, OkxAccount>> createSubAccount(
      {required String subAccount});
  Future<Either<Failure, CreateDepositAddressResponse>> createDepositAddress(
      {required String currency, String? chain});
  Future<Either<Failure, OkxAccount>> getOkxAccount();
  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies();
  Future<Either<Failure, List<Deposit>>> fetchDepositHistory();
  Future<Either<Failure, List<Currency>>> fetchConvertCurrencies();
}
