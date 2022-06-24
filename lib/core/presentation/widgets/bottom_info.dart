import 'package:flutter/material.dart';
import '/core/presentation/themes/themes.dart';

class BottomInfo extends StatelessWidget {
  const BottomInfo({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onCallbackFunction,
  }) : super(key: key);
  final String firstText;
  final String secondText;
  final void Function()? onCallbackFunction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            firstText,
            style: TextStyle(
              fontSize: 14,
              color: context.colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onCallbackFunction,
            child: Text(
              secondText,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
