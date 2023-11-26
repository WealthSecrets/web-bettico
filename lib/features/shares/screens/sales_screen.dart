import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          width: double.infinity,
          margin: AppPaddings.lB,
          padding: AppPaddings.lA,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: ResponsiveWidget.isSmallScreen(context)
                ? const <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))]
                : null,
            borderRadius: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context)
                ? AppBorderRadius.smallAll
                : null,
            border: !ResponsiveWidget.isSmallScreen(context) ? Border.all(color: context.colors.faintGrey) : null,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Avatar(
                    size: 30,
                    imageUrl:
                        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  ),
                  const AppSpacing(h: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Berry Max Exchange'.toUpperCase(),
                          maxLines: 1,
                          style: context.caption.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Project will receive 60% at first release.',
                          maxLines: 1,
                          style: context.overline.copyWith(color: context.colors.text, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  const AppSpacing(h: 8),
                  Column(
                    children: <Widget>[
                      Text(
                        'Sales Start in',
                        style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                      ),
                      Text('00:06:53:29', style: context.overline.copyWith(color: context.colors.text)),
                    ],
                  )
                ],
              ),
              const AppSpacing(v: 8),
              StepProgressIndicator(
                totalSteps: 400,
                currentStep: 250,
                size: 6,
                padding: 0,
                selectedColor: context.colors.primary,
                unselectedColor: context.colors.lightGrey,
                roundedEdges: const Radius.circular(10),
              ),
              const AppSpacing(v: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '100 BNB',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
                  ),
                  Text(
                    '400 BNB',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
                  ),
                ],
              ),
              const AppSpacing(v: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: 'Soft/Hard Cap: ',
                      style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: '250 BNB - 400 BNB',
                          style: context.caption.copyWith(color: context.colors.primary.shade700),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: ResponsiveWidget.isSmallScreen(context)
                        ? const EdgeInsets.symmetric(vertical: 4).add(const EdgeInsets.symmetric(horizontal: 8))
                        : const EdgeInsets.symmetric(vertical: 4).add(const EdgeInsets.symmetric(horizontal: 16)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: context.colors.success,
                    ),
                    child: Center(
                      child: Text(
                        'live',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: ResponsiveWidget.isSmallScreen(context) ? FontWeight.bold : FontWeight.normal,
                          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        itemCount: 100,
      ),
    );
  }
}
