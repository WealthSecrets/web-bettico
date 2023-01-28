import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/deposit/create_deposit_address_response.dart';
import 'package:betticos/features/okx_swap/domain/requests/sub_account/create_subaccount_request.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';
import '../../domain/repositories/okx_repository.dart';

class OkxRepositoryImpl extends Repository implements OkxRepository {
  OkxRepositoryImpl({
    required this.okxRemoteDataSources,
  });

  final OkxRemoteDataSources okxRemoteDataSources;

  @override
  Future<Either<Failure, OkxAccount>> createSubAccount(
          {required String subAccount}) =>
      makeRequest(
        okxRemoteDataSources.createSubAccount(
          request: CreateSubAccountRequest(subAccount: subAccount),
        ),
      );

  @override
  Future<Either<Failure, CreateDepositAddressResponse>> createDepositAddress(
          {required String currency, String? chain}) =>
      makeRequest(
        okxRemoteDataSources.createDepositAddress(
          request:
              CreateDepositAddressRequest(currency: currency, chain: chain),
        ),
      );

  @override
  Future<Either<Failure, OkxAccount>> getOkxAccount() =>
      makeRequest(okxRemoteDataSources.getOkxAccount());

  @override
  Future<Either<Failure, List<Currency>>> fetchAssetCurrencies() =>
      makeRequest(okxRemoteDataSources.fetchAssetCurrencies());

  @override
  Future<Either<Failure, List<Deposit>>> fetchDepositHistory() =>
      makeRequest(okxRemoteDataSources.fetchDepositHistory());

  @override
  Future<Either<Failure, List<Currency>>> fetchConvertCurrencies() =>
      makeRequest(okxRemoteDataSources.fetchAssetCurrencies());
}
