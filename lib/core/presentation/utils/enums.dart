import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:flutter/material.dart';

extension TransactionStatusX on TransactionStatus {
  Color color(BuildContext context) {
    switch (this) {
      case TransactionStatus.failed:
        return context.colors.error;
      case TransactionStatus.successful:
        return context.colors.success;
      case TransactionStatus.rejected:
        return context.colors.textDark;
    }
  }
}

extension TransactionTypeX on TransactionType {
  String transactionAsset() {
    switch (this) {
      case TransactionType.deposit:
        return AssetImages.deposit;
      case TransactionType.withdrawal:
        return AssetImages.withdrawal;
    }
  }
}
