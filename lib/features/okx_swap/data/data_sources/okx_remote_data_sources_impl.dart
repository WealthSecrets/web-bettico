import 'package:betticos/features/okx_swap/data/endpoints/okx_endpoints.dart';
import 'package:betticos/features/okx_swap/data/models/okx_account/okx_account.dart';
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
}
