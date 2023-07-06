import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/deposit/deposit.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({super.key});

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  final OkxController controller = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.getDepositHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Deposit History',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        final List<Deposit> deposits = controller.deposits;
        return AppLoadingBox(
          loading: controller.isFetchingDepositHistory.value,
          child: deposits.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final Deposit deposit = controller.deposits[index];
                    final Currency? currency = controller.getCurrency(deposit.chain);
                    final int timestamp = int.parse(deposit.timestamp);
                    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
                    return ListTile(
                      leading: currency != null && currency.logoLink != null
                          ? SizedBox(
                              width: 40,
                              child: Image.network(currency.logoLink!, height: 40, width: 40),
                            )
                          : const SizedBox(),
                      title: Text(
                        currency?.currency ?? deposit.currency,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.textDark),
                      ),
                      subtitle: Text(
                        currency?.chain ?? deposit.chain,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.text),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${deposit.amount} ${deposit.currency}',
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
                  itemCount: deposits.length,
                  separatorBuilder: (_, __) => Divider(color: context.colors.lightGrey),
                )
              : const AppEmptyScreen(title: 'Nothing Found', message: 'You do not have any deposit history.'),
        );
      }),
    );
  }
}
