// ignore_for_file: invalid_annotation_target
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType { deposit, withdrawal }

enum TransactionStatus { failed, successful, rejected }

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    @JsonKey(name: '_id') required String id,
    String? bet,
    required String user,
    required TransactionType type,
    required double amount,
    required double convertedAmount,
    required String description,
    @JsonKey(name: 'hash') required String transactionHash,
    @JsonKey(name: 'wallet') required String walletAddress,
    String? provider,
    required String token,
    required String convertedToken,
    @JsonKey(name: 'gas') double? estimatedGas,
    @JsonKey(name: 'time') DateTime? date,
    required TransactionStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  factory Transaction.mock() => Transaction(
        id: '637c20107dd5261d9bc35bec',
        bet: '637c20107dd5261d9bc35bec',
        user: '637c20107dd5261d9bc35bec',
        type: Faker().randomGenerator.element(TransactionType.values),
        description: 'Bet Creation',
        amount: 450000,
        convertedAmount: 10,
        walletAddress: '0x1325C81eEF0735cD103056DBD9004DE76769689A',
        transactionHash: '0xd274c5735120ed5a5a4274e872be99b29901feaf23524969e8de9cd7af08f7a9',
        provider: 'metamask',
        status: Faker().randomGenerator.element(TransactionStatus.values),
        token: 'wsc',
        convertedToken: 'usd',
        estimatedGas: 0.0016,
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory Transaction.empty() => Transaction(
        id: '',
        bet: '',
        user: '',
        type: Faker().randomGenerator.element(TransactionType.values),
        amount: 0,
        convertedAmount: 0,
        walletAddress: '',
        description: '',
        transactionHash: '',
        token: '',
        convertedToken: '',
        estimatedGas: 0,
        date: DateTime.now(),
        provider: '',
        status: Faker().randomGenerator.element(TransactionStatus.values),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

extension TransactionStatusX on TransactionStatus {
  String get stringValue => toString().split('.').last;
}

extension TransactionTypeX on TransactionType {
  String get stringValue => toString().split('.').last;
}
