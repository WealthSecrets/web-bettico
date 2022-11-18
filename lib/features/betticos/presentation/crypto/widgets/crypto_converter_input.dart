import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoConverterInput extends StatelessWidget {
   CryptoConverterInput({Key? key,
    required this.onCurrencyChanged,
    required this.onAmountChanged,
    required this.controller,
    this.selectedCurrency,
    this.disableAmountInput = false,
  }) : super(key: key);

  final String? selectedCurrency;
  final Function(String currency) onCurrencyChanged;
  final Function(double amount) onAmountChanged;
  final TextEditingController controller;
  final bool disableAmountInput;

  final List<String> values = <String>['BNB', 'USDT', 'BUSD'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AppTextInput(
          disabled: disableAmountInput,
          controller: controller,
          textAlignVertical: TextAlignVertical.bottom,
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
              final bool isDot = amountInString.split('')[amountInString.length - 1] == '.';
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
          child: AppSelectField<String>(
            value: selectedCurrency,
            onChanged: onCurrencyChanged,
            options: values,
            customTitleBuilder: (BuildContext context, String? currency, bool isSelected) => Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                  child: SvgPicture.asset(
                    '',
                    height: 30,
                    width: 30,
                  ),
                ),
                const AppSpacing(h: 20),
                Text(
                  currency!,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? context.colors.primary : context.colors.text,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            customChildBuilder: (BuildContext context, String? item) => SizedBox(
              height: kToolbarHeight - 7,
              child: Row(
                children: <Widget>[
                  const AppSpacing(h: 7),
                  if (item != null) ...<Widget>[
                    SizedBox(
                      width: 25,
                      child: SvgPicture.asset(
                        '',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const AppSpacing(h: 5),
                    Text(
                      item,
                      style: TextStyle(color: context.colors.textDark, fontSize: 14,),
                    ),
                  ],
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: context.colors.textDark,
                  ),
                  const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFD2CDDE)),
                ],
              ),
            ),
            titleBuilder: (_, String item) => item,
          ),
        ),
      ],
    );
  }
}
