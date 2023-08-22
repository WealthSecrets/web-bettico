import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/data/models/bank/resolve_response.dart';
import 'package:betticos/features/okx_swap/data/models/recipient/recipient.dart';
import 'package:betticos/features/okx_swap/data/models/transfer/transfer.dart';
import 'package:dartz/dartz.dart';

abstract class PaystackRepository {
  Future<Either<Failure, List<Bank>>> fetchBankOrTelcos({required String currency, String? type});
  Future<Either<Failure, ResolveResponse>> resolveAccount({required String accoutNumber, required String bankCode});
  Future<Either<Failure, Recipient>> createRecipient({
    required String type,
    required String name,
    required String accountNumber,
    required String bankCode,
    required String currency,
    required double usdtAmount,
    required double amount,
    required String destination,
  });
  Future<Either<Failure, Transfer>> initiateTransfer({
    required String source,
    required String accountNumber,
    required double amount,
    required String recipientCode,
  });
  Future<Either<Failure, Transfer>> finalizeTransfer({required String transferCode, required String otp});
}
