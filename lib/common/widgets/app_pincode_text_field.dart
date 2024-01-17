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
    this.enabled = true,
  });

  final List<TextInputFormatter> inputFormatters;
  final void Function(String pin) onChanged;
  final void Function(String pin)? onCompleted;
  final String? label;
  final int length;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool enabled;

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
                style: context.overline.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        PinCodeTextField(
          enabled: enabled,
          appContext: context,
          length: length,
          keyboardType: textInputType ?? TextInputType.visiblePassword,
          autoFocus: true,
          showCursor: false,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          enableActiveFill: true,
          textStyle: context.body1.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colors.textDark,
          ),
          validator: validator,
          errorTextSpace: 20,
          errorAnimationDuration: 400,
          inputFormatters: inputFormatters,
          pinTheme: PinTheme(
            fieldOuterPadding: EdgeInsets.zero,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            borderWidth: 1,
            activeColor: context.colors.pinColor,
            activeFillColor: context.colors.pinColor,
            inactiveFillColor: const Color(0xFFFBFCFD),
            selectedFillColor: const Color(0xFFE9ECEF),
            inactiveColor: const Color(0xFFFBFCFD),
            selectedColor: const Color(0xFFE9ECEF),
            fieldHeight: 45.w,
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
