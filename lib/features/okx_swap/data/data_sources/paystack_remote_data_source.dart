import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';
import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';
import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:betticos/features/okx_swap/domain/requests/bank/bank_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/recipient/recipient_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/resolve_account/resolve_account_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/finalize_transfer_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/transfer_request.dart';

abstract class PayStackRemoteDataSource {
  Future<List<Bank>> fetchBankOrTelcos({required BankRequest request});
  Future<ResolveResponse> resolveAccount({required ResolveAccountRequest request});
  Future<Recipient> createRecipient({required RecipientRequest request});
  Future<Transfer> initiateTransfer({required TransferRequest request});
  Future<Transfer> finalizeTransfer({required FinalizeTransferRequest request});
}
