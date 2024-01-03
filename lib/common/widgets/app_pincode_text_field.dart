import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '/core/core.dart';

class AppPinCodeTextField extends StatelessWidget {
  const AppPinCodeTextField({
    super.key,
    required this.onChanged,
    required this.length,
    this.onCompleted,
    this.textInputType,
    this.inputFormatters = const <TextInputFormatter>[],
    this.label,
    this.validator,
  });

  final List<TextInputFormatter> inputFormatters;
  final Function(String pin) onChanged;
  final Function(String pin)? onCompleted;
  final String? label;
  final int length;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                label!,
                textAlign: TextAlign.left,
                style: context.overline.copyWith(color: context.colors.text, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        PinCodeTextField(
          appContext: context,
          length: length,
          keyboardType: textInputType ?? TextInputType.visiblePassword,
          autoFocus: true,
          showCursor: false,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          enableActiveFill: true,
          textStyle: context.sub1.copyWith(fontWeight: FontWeight.w800, color: context.colors.primary),
          validator: validator,
          errorTextSpace: 20,
          errorAnimationDuration: 400,
          inputFormatters: inputFormatters,
          pinTheme: PinTheme(
            fieldOuterPadding: EdgeInsets.zero,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            borderWidth: 1.0,
            activeColor: context.colors.primary.shade100,
            activeFillColor: context.colors.primary.shade50,
            inactiveFillColor: context.colors.primary.shade50,
            selectedFillColor: context.colors.primary.shade100,
            inactiveColor: context.colors.primary.shade100,
            selectedColor: context.colors.primary.shade100,
            fieldHeight: 60.w,
            fieldWidth: max(42.w, (1.sw / length) - (76 / 6) - (48.w / length)),
          ),
          animationDuration: const Duration(milliseconds: 700),
          backgroundColor: Colors.transparent,
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (_) {
            return true;
          },
        ),
      ],
    );
  }
}
