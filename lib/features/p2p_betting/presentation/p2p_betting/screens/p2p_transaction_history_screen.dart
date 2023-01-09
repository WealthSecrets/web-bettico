import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/data/models/transaction/transaction.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final P2PBetController controller = Get.find<P2PBetController>();

  @override
  void initState() {
    super.initState();
    controller.getMyTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isFetchingTransactions.value,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Transaction History',
              style: TextStyle(
                color: context.colors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: context.colors.black),
          ),
          body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: context.colors.faintGrey,
            ),
            itemCount: controller.myTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              final Transaction transaction = controller.myTransactions[index];
              return ListTile(
                leading: Image.asset(
                  transaction.type.transactionAsset(),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  transaction.description,
                  style: TextStyle(
                    color: context.colors.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  StringUtils.capitalizeFirst(transaction.status.stringValue),
                  style: TextStyle(
                    color: transaction.status.color(context),
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  '${transaction.convertedAmount.toStringAsFixed(2)} ${transaction.convertedToken.toUpperCase()}',
                  style: TextStyle(
                    color: context.colors.text,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
