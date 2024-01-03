import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class AppCountryPicker extends StatelessWidget {
  const AppCountryPicker({
    super.key,
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.showFlag = true,
    this.showFlagMain,
    this.showCountryOnly = false,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.textStyle,
    this.dialogTextStyle,
  });

  final Function(CountryCode)? onChanged;
  final Function(CountryCode?)? onInit;
  final String? initialSelection;
  final bool showFlag;
  final bool? showFlagMain;
  final bool showCountryOnly;
  final bool showOnlyCountryWhenClosed;
  final bool alignLeft;
  final TextStyle? textStyle;
  final TextStyle? dialogTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Add Location',
          style: context.caption.copyWith(fontWeight: FontWeight.bold, color: context.colors.black),
        ),
        const AppSpacing(v: 3),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CountryCodePicker(
            onChanged: onChanged,
            dialogTextStyle: dialogTextStyle,
            showFlagMain: showFlagMain,
            showFlag: showFlag,
            initialSelection: initialSelection,
            showCountryOnly: showCountryOnly,
            showOnlyCountryWhenClosed: showOnlyCountryWhenClosed,
            alignLeft: alignLeft,
            textStyle: textStyle,
            onInit: onInit,
          ),
        ),
      ],
    );
  }
}
