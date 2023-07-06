import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/withdrawal/withdrawal_history.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/getx/withdrawal_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalHistoryScreen extends StatefulWidget {
  const WithdrawalHistoryScreen({super.key});

  @override
  State<WithdrawalHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<WithdrawalHistoryScreen> {
  final WithdrawalController controller = Get.find<WithdrawalController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.getWithdrawalHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Withdrawal History',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        final List<WithdrawalHistory> withdrawals = controller.withdrawals;
        return AppLoadingBox(
          loading: controller.isFetchingWithdrawalHistory.value,
          child: withdrawals.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final WithdrawalHistory withdrawal = controller.withdrawals[index];
                    final Currency? currency = okxController.getCurrency(withdrawal.chain);
                    final int timestamp = int.parse(withdrawal.timestamp);
                    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
                    return ListTile(
                      leading: currency != null && currency.logoLink != null
                          ? SizedBox(
                              width: 40,
                              child: Image.network(currency.logoLink!, height: 40, width: 40),
                            )
                          : const SizedBox(),
                      title: Text(
                        currency?.currency ?? withdrawal.currency,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.colors.textDark),
                      ),
                      subtitle: Text(
                        currency?.chain ?? withdrawal.chain,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.text),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${withdrawal.amount} ${withdrawal.currency}',
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
                  itemCount: withdrawals.length,
                  separatorBuilder: (_, __) => Divider(color: context.colors.lightGrey),
                )
              : const AppEmptyScreen(title: 'Nothing Found', message: 'You do not have any withdrawals history.'),
        );
      }),
    );
  }
}
