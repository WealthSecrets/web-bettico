import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:flutter/material.dart';

class ListTileColumn extends StatelessWidget {
  const ListTileColumn({
    Key? key,
    required this.title,
    required this.amount,
    this.currency,
    required this.quoteCurrency,
  }) : super(key: key);
  final String title;
  final Currency? currency;
  final String quoteCurrency;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: context.colors.text,
          ),
        ),
        const SizedBox(height: 5),
        ListTile(
          leading: currency != null && currency!.logoLink != null
              ? SizedBox(
                  width: 40,
                  child: Image.network(
                    currency!.logoLink!,
                    height: 40,
                    width: 40,
                  ),
                )
              : null,
          title: Text(
            currency?.currency ?? quoteCurrency,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
