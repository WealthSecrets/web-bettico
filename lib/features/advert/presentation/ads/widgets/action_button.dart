import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.iconData,
    required this.textData,
    this.onPressed,
    this.reverse = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool reverse;
  final IconData iconData;
  final String textData;

  @override
  Widget build(BuildContext context) {
    final Icon icon = Icon(iconData, color: Colors.white, size: 20.0);
    final Text text = Text(textData, style: context.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold));
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: reverse ? 15 : 8, right: reverse ? 8 : 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!reverse) icon else text,
            if (!reverse) text else icon,
          ],
        )),
      ),
    );
  }
}
