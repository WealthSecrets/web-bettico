import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
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
  Future<Either<Failure, OkxAccount>> createSubAccount({
    required String subAccount,
    String? label,
  }) =>
      makeRequest(
        okxRemoteDataSources.createSubAccount(
          request: CreateSubAccountRequest(
            subAccount: subAccount,
            label: label,
          ),
        ),
      );
}
