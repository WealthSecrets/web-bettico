import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/core/core.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    Key? key,
    required this.onDateTimeChanged,
    this.initialDate,
    this.validator,
    this.backgroundColor,
    this.showIcon = true,
    this.labelText,
    this.lableStyle,
    this.disabled = false,
  }) : super(key: key);
  final void Function(DateTime)? onDateTimeChanged;
  final DateTime? initialDate;
  final String? labelText;
  final TextStyle? lableStyle;
  final bool showIcon;
  final Color? backgroundColor;
  final String? Function(DateTime?)? validator;
  final bool disabled;

  @override
  _AppDatePickerState createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late final ValueNotifier<DateTime?> _selectedDate;
  late final TextEditingController controller;

  @override
  void initState() {
    _selectedDate = ValueNotifier<DateTime?>(widget.initialDate);
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _selectedDate.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            widget.labelText!,
            textAlign: TextAlign.left,
            style: widget.lableStyle ??
                context.overline.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        InkWell(
          onTap: () async {
            await showMaterialModalBottomSheet<void>(
              bounce: true,
              animationCurve: Curves.fastLinearToSlowEaseIn,
              shape: RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.largeTop),
              builder: (BuildContext context) {
                return SizedBox(
                  height: .3.sh,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: context.body1.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: context.colors.textDark,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _selectedDate.value,
                      onDateTimeChanged: (DateTime dateTime) {
                        _selectedDate.value = DateTime.utc(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                        );
                        controller.value = TextEditingValue(
                            text: AppDateUtils.format(dateTime));
                        if (widget.onDateTimeChanged != null &&
                            _selectedDate.value != null) {
                          widget.onDateTimeChanged!(_selectedDate.value!);
                        }
                        widget.validator!(_selectedDate.value);
                      },
                    ),
                  ),
                );
              },
              context: context,
            );
          },
          child: ValueListenableBuilder<DateTime?>(
            valueListenable: _selectedDate,
            builder: (BuildContext context, DateTime? date, _) {
              return IgnorePointer(
                ignoring: widget.disabled,
                child: AppTextInput(
                  disabled: widget.disabled,
                  hideLabel: true,
                  validator: (_) {
                    return widget.validator!(date);
                  },
                  initialValue: date == null ? null : AppDateUtils.format(date),
                  controller: controller,
                  backgroundColor:
                      widget.backgroundColor ?? context.colors.primary.shade50,
                  hintText: '',
                  onChanged: (_) {},
                  prefixIcon: widget.showIcon
                      ? Icon(
                          Ionicons.calendar_outline,
                          color: context.colors.hintLight,
                          size: 18,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
