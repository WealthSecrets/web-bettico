// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/utils/enums.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class TransactionHistoryScreenRouteArgument {
  const TransactionHistoryScreenRouteArgument({this.isSale});

  final bool? isSale;
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
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
    final TransactionHistoryScreenRouteArgument? args =
        ModalRoute.of(context)!.settings.arguments as TransactionHistoryScreenRouteArgument?;
    return Obx(
      () {
        final List<Transaction> transactions = controller.getBetTransactions(args?.isSale);
        return AppLoadingBox(
          loading: controller.isFetchingTransactions.value,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: 16.0,
                left: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Ionicons.arrow_back_sharp, size: 24, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Transactions History',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: transactions.isEmpty
                        ? const AppEmptyScreen(message: 'No transactions were found.')
                        : ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => Divider(
                              color: context.colors.faintGrey,
                            ),
                            padding: EdgeInsets.zero,
                            itemCount: transactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Transaction transaction = transactions[index];
                              return ListTile(
                                onTap: () => showTransactionDetails(context, transaction),
                                leading: Image.asset(transaction.type.transactionAsset(), width: 24, height: 24),
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
                                  style: TextStyle(color: transaction.status.color(context), fontSize: 12),
                                ),
                                trailing: Text(
                                  '${transaction.convertedAmount.toStringAsFixed(2)} ${transaction.convertedToken.toUpperCase()}',
                                  style: TextStyle(color: context.colors.text, fontSize: 12),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
              js.context.callMethod('open', <String>['https://bscscan.com//tx/${transaction.transactionHash}']);
            },
          ),
        ),
      ),
    );
  }
}
