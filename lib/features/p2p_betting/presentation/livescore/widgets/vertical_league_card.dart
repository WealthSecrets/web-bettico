import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class VerticalLeagueCard extends StatelessWidget {
  const VerticalLeagueCard({
    Key? key,
    this.onTap,
    required this.imagePath,
    required this.name,
    this.isSelected,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 105,
        width: 90,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 4, right: 4, top: 5, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.button,
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Color.fromRGBO(69, 52, 127, 0.3),
            ),
          ],
          border: isSelected ?? false
              ? Border.all(
                  style: BorderStyle.solid,
                  color: context.colors.primary,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              imagePath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
