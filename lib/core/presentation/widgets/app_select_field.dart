import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '/core/core.dart';

class AppSelectField<T> extends StatefulWidget {
  const AppSelectField({
    Key? key,
    required this.onChanged,
    this.value,
    this.validator,
    this.showIcon = true,
    this.labelText,
    this.lableStyle,
    this.backgroundColor,
    required this.options,
    required this.titleBuilder,
    this.customChildBuilder,
    this.customTitleBuilder,
    this.disabled = false,
    this.header,
  }) : super(key: key);
  final void Function(T) onChanged;
  final T? value;
  final String? labelText;
  final TextStyle? lableStyle;
  final Color? backgroundColor;
  final bool showIcon;
  final bool disabled;
  final List<T> options;
  final String? Function(T)? validator;
  final String Function(
    BuildContext,
    T,
  ) titleBuilder;
  final Widget Function(BuildContext, T?)? customChildBuilder;
  final Widget Function(BuildContext, T?, bool isActive)? customTitleBuilder;

  final Widget Function(BuildContext)? header;

  @override
  _AppSelectFieldState<T> createState() => _AppSelectFieldState<T>();
}

class _AppSelectFieldState<T> extends State<AppSelectField<T>> {
  late final ValueNotifier<T?> _selectedItem;
  late final TextEditingController controller;

  @override
  void initState() {
    _selectedItem = ValueNotifier<T?>(widget.value);
    controller = TextEditingController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSelectField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedItem.value = widget.value;
      controller.value = widget.value == null
          ? TextEditingValue.empty
          : TextEditingValue(text: widget.titleBuilder(context, widget.value!));
    }
  }

  @override
  void dispose() {
    _selectedItem.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.labelText != null)
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                builder: (BuildContext context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .7,
                      minHeight: MediaQuery.of(context).size.height * .6,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        controller: ModalScrollController.of(context),
                        itemCount: widget.options.length,
                        separatorBuilder: (_, __) => const SizedBox(),
                        itemBuilder: (BuildContext context, int index) {
                          final T item = widget.options[index];
                          final bool selected = item == _selectedItem.value;
                          final TextButton childListItem = TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: selected
                                  ? context.colors.primary.shade100
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              widget.onChanged(item);
                              _selectedItem.value = item;
                              controller.value = TextEditingValue(
                                  text: widget.titleBuilder(context, item));
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: AppPaddings.mH.add(AppPaddings.mV),
                              child: widget.customTitleBuilder != null
                                  ? widget.customTitleBuilder!(
                                      context, item, selected)
                                  : Text(
                                      widget.titleBuilder(context, item),
                                      style: context.body2.copyWith(
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.w300,
                                        color: selected
                                            ? context.colors.primary
                                            : context.colors.textDark,
                                      ),
                                    ),
                            ),
                          );
                          if (index == 0 && widget.header != null) {
                            return Column(
                              children: <Widget>[
                                widget.header!(context),
                                childListItem
                              ],
                            );
                          }

                          return childListItem;
                        },
                      ),
                    ),
                  );
                },
                context: context,
              );
            },
            child: ValueListenableBuilder<T?>(
              valueListenable: _selectedItem,
              builder: (BuildContext context, T? item, _) {
                return IgnorePointer(
                  child: widget.customChildBuilder != null
                      ? widget.customChildBuilder!(context, item)
                      : AppTextInput(
                          disabled: widget.disabled,
                          hideLabel: true,
                          validator: (_) {
                            return null;
                          },
                          initialValue: item == null
                              ? ''
                              : widget.titleBuilder(context, item),
                          controller: controller,
                          backgroundColor: widget.backgroundColor ??
                              context.colors.primary.shade50,
                          hintText: '',
                          onChanged: (_) {},
                          suffixIcon: widget.showIcon
                              ? Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: context.colors.text,
                                )
                              : null,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
