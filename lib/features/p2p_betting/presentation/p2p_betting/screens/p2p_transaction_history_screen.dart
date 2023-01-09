// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/utils/enums.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
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
          body: controller.myTransactions.isEmpty
              ? const AppEmptyScreen(message: 'No transactions were found.')
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: context.colors.faintGrey,
                  ),
                  itemCount: controller.myTransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Transaction transaction =
                        controller.myTransactions[index];
                    return ListTile(
                      onTap: () => showTransactionDetails(context, transaction),
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
                        StringUtils.capitalizeFirst(
                            transaction.status.stringValue),
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

  void showTransactionDetails(BuildContext context, Transaction transaction) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => Center(
        child: Container(
          width: 500,
          height: 440,
          margin: AppPaddings.mH,
          child: AppTransactionDailog(
            transaction: transaction,
            onPressed: () {
              js.context.callMethod('open', <String>[
                'https://bscscan.com//tx/${transaction.transactionHash}'
              ]);
            },
          ),
        ),
      ),
    );
  }
}
