import 'package:betticos/core/errors/failure.dart';
import 'package:betticos/core/utils/repository.dart';
import 'package:betticos/features/okx_swap/data/data_sources/paystack_remote_data_source.dart';
import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';
import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';
import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:betticos/features/okx_swap/domain/repositories/paystack_repository.dart';
import 'package:betticos/features/okx_swap/domain/requests/bank/bank_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/recipient/recipient_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/finalize_transfer_request.dart';
import 'package:betticos/features/okx_swap/domain/requests/transfer/transfer_request.dart';
import 'package:dartz/dartz.dart';

import '../../domain/requests/resolve_account/resolve_account_request.dart';

class PaystackRepositoryImpl extends Repository implements PaystackRepository {
  PaystackRepositoryImpl({required this.paystackRemoteDataSource});

  final PayStackRemoteDataSource paystackRemoteDataSource;

  @override
  Future<Either<Failure, Recipient>> createRecipient({
    required String type,
    required String name,
    required String accountNumber,
    required String bankCode,
    required String currency,
    required double usdtAmount,
    required double amount,
    required String destination,
  }) async =>
      makeRequest(
        paystackRemoteDataSource.createRecipient(
          request: RecipientRequest(
            currency: currency,
            type: type,
            name: name,
            accountNumber: accountNumber,
            bankCode: bankCode,
            usdAmount: usdtAmount,
            amount: amount,
            destination: destination,
          ),
        ),
      );

  @override
  Future<Either<Failure, List<Bank>>> fetchBankOrTelcos({required String currency, String? type}) => makeRequest(
        paystackRemoteDataSource.fetchBankOrTelcos(request: BankRequest(currency: currency, type: type)),
      );

  @override
  Future<Either<Failure, Transfer>> finalizeTransfer({required String transferCode, required String otp}) =>
      makeRequest(
        paystackRemoteDataSource.finalizeTransfer(
          request: FinalizeTransferRequest(transferCode: transferCode, otp: otp),
        ),
      );

  @override
  Future<Either<Failure, Transfer>> initiateTransfer({
    required String source,
    required String accountNumber,
    required double amount,
    required String recipientCode,
  }) =>
      makeRequest(
        paystackRemoteDataSource.initiateTransfer(
          request: TransferRequest(
            source: source,
            accountNumber: accountNumber,
            amount: amount,
            recipientCode: recipientCode,
          ),
        ),
      );

  @override
  Future<Either<Failure, ResolveResponse>> resolveAccount({required String accoutNumber, required String bankCode}) =>
      makeRequest(
        paystackRemoteDataSource.resolveAccount(
          request: ResolveAccountRequest(accoutNumber: accoutNumber, bankCode: bankCode),
        ),
      );
}
