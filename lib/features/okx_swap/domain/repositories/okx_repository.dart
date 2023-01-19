import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:dartz/dartz.dart';

import '/core/errors/failure.dart';

abstract class OkxRepository {
  Future<Either<Failure, OkxAccount>> createSubAccount({
    required String subAccount,
    String? label,
  });
  Future<Either<Failure, OkxAccount>> getOkxAccount();
  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies();
  Future<Either<Failure, List<Currency>>> fetchConvertCurrencies();
}
