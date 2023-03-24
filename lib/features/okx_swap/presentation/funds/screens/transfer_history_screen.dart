import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/funds/transfer_history.dart';
import 'package:betticos/features/okx_swap/presentation/funds/getx/funds_controller.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferHistoryScreen extends StatefulWidget {
  const TransferHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransferHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<TransferHistoryScreen> {
  final FundsController controller = Get.find<FundsController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.getTransferHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Fund Transfer History',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        final List<TransferHistory> transfers = controller.transfers;
        return AppLoadingBox(
          loading: controller.isFetchingTransferHistory.value,
          child: transfers.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final TransferHistory transfer = transfers[index];
                    final Currency? currency =
                        okxController.getCurrencyByCurrency(transfer.currency);
                    final int timestamp = int.parse(transfer.timestamp);
                    final DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(timestamp);
                    return ListTile(
                      leading: currency != null && currency.logoLink != null
                          ? SizedBox(
                              width: 40,
                              child: Image.network(
                                currency.logoLink!,
                                height: 40,
                                width: 40,
                              ),
                            )
                          : const SizedBox(),
                      title: Text(
                        currency?.currency ?? transfer.currency,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textDark,
                        ),
                      ),
                      subtitle: Text(
                        'success',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: context.colors.success,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${transfer.amount} ${transfer.currency}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: context.colors.primary.shade700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TimeCard(dateTime: date),
                        ],
                      ),
                    );
                  },
                  itemCount: transfers.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: context.colors.lightGrey),
                )
              : const AppEmptyScreen(
                  title: 'Nothing Found',
                  message: 'You do not have any transfer history.',
                ),
        );
      }),
    );
  }
}
