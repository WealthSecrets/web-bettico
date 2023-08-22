import 'package:betticos/features/okx_swap/data/endpoints/paystack_endpoints.dart';
import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';

import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';

import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';

import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';

import 'package:betticos/features/okx_swap/domain/requests/bank/bank_request.dart';

import 'package:betticos/features/okx_swap/domain/requests/recipient/recipient_request.dart';

import 'package:betticos/features/okx_swap/domain/requests/resolve_account/resolve_account_request.dart';

import 'package:betticos/features/okx_swap/domain/requests/transfer/finalize_transfer_request.dart';

import 'package:betticos/features/okx_swap/domain/requests/transfer/transfer_request.dart';

import '/core/utils/http_client.dart';
import 'paystack_remote_data_source.dart';

class PaystackRemoteDataSourceImpl implements PayStackRemoteDataSource {
  const PaystackRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<Recipient> createRecipient({required RecipientRequest request}) async {
    final Map<String, dynamic> json = await _client.post(PaystackEndpoints.createRecipient, body: request.toJson());
    return Recipient.fromJson(json);
  }

  @override
  Future<List<Bank>> fetchBankOrTelcos({required BankRequest request}) async {
    final Map<String, dynamic> json = await _client.get(PaystackEndpoints.methodList(request.currency, request.type));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Bank>.from(
      items.map<Bank>((dynamic json) => Bank.fromJson(json as Map<String, dynamic>)),
    );
  }

  @override
  Future<Transfer> finalizeTransfer({required FinalizeTransferRequest request}) async {
    final Map<String, dynamic> json = await _client.post(PaystackEndpoints.finalizeTransfer, body: request.toJson());
    return Transfer.fromJson(json);
  }

  @override
  Future<Transfer> initiateTransfer({required TransferRequest request}) async {
    final Map<String, dynamic> json = await _client.post(PaystackEndpoints.initiateTransfer, body: request.toJson());
    return Transfer.fromJson(json);
  }

  @override
  Future<ResolveResponse> resolveAccount({required ResolveAccountRequest request}) async {
    final Map<String, dynamic> json =
        await _client.get(PaystackEndpoints.resolveAccount(request.accoutNumber, request.bankCode));
    return ResolveResponse.fromJson(json);
  }
}
