import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:flutter/material.dart';

class CryptoConverterInput extends StatelessWidget {
  const CryptoConverterInput({
    Key? key,
    required this.onCurrencyChanged,
    required this.onAmountChanged,
    required this.controller,
    required this.options,
    this.selectedCurrency,
    this.disableAmountInput = false,
  }) : super(key: key);

  final Currency? selectedCurrency;
  final Function(Currency currency) onCurrencyChanged;
  final Function(double amount) onAmountChanged;
  final TextEditingController controller;
  final bool disableAmountInput;
  final List<Currency> options;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AppTextInput(
          disabled: disableAmountInput,
          controller: controller,
          prefixIcon: const SizedBox(width: 102),
          hintText: 'Enter Amount',
          textInputType: const TextInputType.numberWithOptions(decimal: true),
          validator: (String amountInString) {
            final double? amount = double.tryParse(amountInString);
            if (amount == null) {
              return 'Invalid input';
            }
            return null;
          },
          onChanged: (String amountInString) {
            if (amountInString.isEmpty) {
              onAmountChanged(0.0);
            } else {
              final bool isDot =
                  amountInString.split('')[amountInString.length - 1] == '.';
              if (!isDot) {
                final double? amount = double.tryParse(amountInString);
                if (amount != null) {
                  if (amount > 0) {
                    onAmountChanged(amount);
                  }
                }
              }
            }
          },
        ),
        Positioned.fill(
          right: null,
          child: AppSelectField<Currency>(
            value: selectedCurrency,
            onChanged: onCurrencyChanged,
            options: options,
            customTitleBuilder:
                (BuildContext context, Currency? currency, bool isSelected) =>
                    Row(
              children: <Widget>[
                if (currency != null && currency.logoLink != null)
                  SizedBox(
                    width: 30,
                    child: Image.network(
                      currency.logoLink!,
                      height: 30,
                      width: 30,
                    ),
                  ),
                const AppSpacing(h: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      currency!.currency,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.textDark,
                        fontSize: 16,
                      ),
                    ),
                    if (currency.name != null)
                      Text(
                        currency.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: context.colors.text,
                          fontSize: 10,
                        ),
                      ),
                  ],
                )
              ],
            ),
            customChildBuilder: (BuildContext context, Currency? item) =>
                SizedBox(
              height: kToolbarHeight - 7,
              child: Row(
                children: <Widget>[
                  const AppSpacing(h: 7),
                  if (item != null) ...<Widget>[
                    if (item.logoLink != null)
                      SizedBox(
                        width: 25,
                        child: Image.network(
                          item.logoLink!,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    const AppSpacing(h: 5),
                    Text(
                      item.currency,
                      style: TextStyle(
                        color: context.colors.textDark,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: context.colors.textDark,
                  ),
                  const VerticalDivider(
                      width: 1, thickness: 1, color: Color(0xFFD2CDDE)),
                ],
              ),
            ),
            titleBuilder: (_, Currency item) => item.currency,
          ),
        ),
      ],
    );
  }
}