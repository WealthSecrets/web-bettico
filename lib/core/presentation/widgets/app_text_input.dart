import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    this.inputFormatters,
    this.labelText,
    this.hintText,
    this.errorStyle,
    this.initialValue,
    this.autoFocus = false,
    this.controller,
    required this.onChanged,
    required this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.minLines,
    this.lableStyle,
    this.disabled = false,
    this.hideLabel = false,
    this.textInputType,
    this.obscureText = false,
    this.showObscureTextToggle = false,
    this.focusNode,
    this.padding,
    this.textInputAction,
    this.onFieldSubmitted,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.prefixIcon,
    this.suffixIcon,
    this.infoText,
    this.textAlign,
    this.textAlignVertical,
    this.borderRadius,
  });

  final String? hintText;
  final String? labelText;
  final int maxLines;
  final int? maxLength;
  final int? minLines;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final bool obscureText;
  final EdgeInsets? padding;
  final bool disabled;
  final bool hideLabel;
  final TextStyle? lableStyle;
  final TextStyle? errorStyle;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  final bool showObscureTextToggle;
  final String? Function(String) validator;
  final String? infoText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final BorderRadius? borderRadius;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> with TickerProviderStateMixin {
  FocusNode? focusNode;
  TextEditingController? controller;
  late ValueNotifier<bool> obscureTextValueListenable;
  ValueNotifier<bool> dirtyValueListenable = ValueNotifier<bool>(false);

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    obscureTextValueListenable = ValueNotifier<bool>(widget.obscureText);
    controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      controller!.text = widget.initialValue!;
    }

    controller!.addListener(() {
      if (controller!.value.text.isNotEmpty) {
        dirtyValueListenable.value = true;
      } else {}
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    if (widget.controller == null) {
      controller!.dispose();
    }
    dirtyValueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.labelText != null && !widget.hideLabel)
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                widget.labelText!,
                textAlign: TextAlign.left,
                style: widget.lableStyle ??
                    TextStyle(
                      color: context.colors.text,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
              ),
            ),
          Container(
            constraints: BoxConstraints(minHeight: max(40.h.toDouble(), 40)),
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? AppBorderRadius.largeAll,
              color: widget.backgroundColor ?? context.colors.primary.shade50,
            ),
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 300),
              opacity: widget.disabled ? .4 : 1.0,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 800),
                    transform: Matrix4.identity()
                      ..translate(
                        0.0,
                        widget.hideLabel
                            ? 0.0
                            : focusNode!.hasFocus || controller!.text.isNotEmpty
                                ? .0
                                : 0.0,
                      ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: obscureTextValueListenable,
                      builder: (
                        BuildContext context,
                        bool obscuringText,
                        Widget? child,
                      ) {
                        return TextFormField(
                          focusNode: focusNode,
                          autovalidateMode: focusNode!.hasFocus && dirtyValueListenable.value
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          obscuringCharacter: '*',
                          obscureText: obscuringText,
                          controller: controller,
                          cursorColor: widget.textColor,
                          textInputAction: widget.textInputAction,
                          maxLength: widget.maxLength,
                          maxLines: widget.maxLines,
                          autofocus: widget.autoFocus,
                          textAlignVertical: widget.textAlignVertical,
                          minLines: widget.minLines,
                          keyboardType: widget.textInputType,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: widget.textColor ?? context.colors.textDark,
                            fontSize: 14,
                          ),
                          onChanged: widget.onChanged,
                          textAlign: widget.textAlign ?? TextAlign.start,
                          inputFormatters: widget.inputFormatters,
                          onFieldSubmitted: widget.onFieldSubmitted,
                          decoration: InputDecoration(
                            contentPadding: widget.padding ?? const EdgeInsets.all(5),
                            fillColor: context.colors.background,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: widget.prefixIcon,
                            suffixIcon: widget.suffixIcon,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: widget.hintColor ?? context.colors.hint,
                              height: 1.4,
                              fontSize: 14,
                            ),
                            hintText: widget.hintText,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: obscureTextValueListenable,
                      builder: (BuildContext context, bool obscuringText, Widget? child) {
                        if (!widget.showObscureTextToggle || !focusNode!.hasFocus && !widget.obscureText) {
                          return const SizedBox(height: 20);
                        }

                        return AnimatedSwitcher(
                          reverseDuration: Duration.zero,
                          transitionBuilder: (Widget? child, Animation<double> animation) {
                            final Animation<double> offset = Tween<double>(begin: 0, end: 1.0).animate(animation);
                            return ScaleTransition(scale: offset, child: child);
                          },
                          switchInCurve: Curves.elasticOut,
                          duration: const Duration(milliseconds: 700),
                          child: IconButton(
                            key: ValueKey<bool>(obscuringText),
                            onPressed: () => obscureTextValueListenable.value = !obscuringText,
                            icon: obscuringText
                                ? Icon(Ionicons.eye_sharp, color: context.colors.hintLight, size: 18)
                                : Icon(Ionicons.eye_off_sharp, color: context.colors.hintLight, size: 18),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller!,
            builder: (BuildContext context, TextEditingValue textEditingValue, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: dirtyValueListenable,
                builder: (BuildContext context, bool dirty, _) {
                  final bool showError = (widget.validator(textEditingValue.text) is String) && dirty;
                  return AnimatedSize(
                    curve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 900),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Builder(
                          key: ValueKey<bool>(showError || widget.infoText == null),
                          builder: (_) {
                            if (showError) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  widget.validator(controller!.value.text)!,
                                  style: widget.errorStyle ?? TextStyle(color: context.colors.error, fontSize: 12),
                                ),
                              );
                            }
                            return widget.infoText != null
                                ? Text(widget.infoText!, style: TextStyle(fontSize: 12, color: context.colors.text))
                                : const SizedBox();
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
