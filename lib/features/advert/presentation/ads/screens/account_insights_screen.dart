import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'account_reached_screen.dart';

class AccountInsightsScreen extends StatelessWidget {
  const AccountInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Insights',
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SelectableButton(text: 'Awaiting', selected: true, onPressed: () {}),
                SelectableButton(text: 'Ongoing', selected: false, onPressed: () {}),
                SelectableButton(text: 'Completed', selected: false, onPressed: () {}),
              ],
            ),
            const SizedBox(height: 32),
            const AccountReachedScreen(),
          ],
        ),
      ),
    );
  }
}
