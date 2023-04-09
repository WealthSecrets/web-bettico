import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/social_buttons_row.dart';
import 'package:flutter/material.dart';

class RightLoginContainer extends StatelessWidget {
  const RightLoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: AppBorderRadius.smallAll,
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colors.black,
            ),
          ),
          const SizedBox(height: 16),
          SocialButtonsRow(),
        ],
      ),
    );
  }
}
