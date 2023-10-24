import 'package:betticos/core/core.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class Avatrade extends StatelessWidget {
  const Avatrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Avatrade,', style: context.caption.copyWith(color: context.colors.text)),
            Text('Links', style: context.body2.copyWith(color: context.colors.textDark)),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: AppPaddings.lT,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppSpacing(v: 16),
            _QuickActionsView(),
            AppSpacing(v: 24),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsView extends StatelessWidget {
  const _QuickActionsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppPaddings.lH,
          child: Text(
            'Quick Actions',
            style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
          ),
        ),
        const AppSpacing(v: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardButton(
              imagePath: AssetImages.register,
              backgroundColor: context.colors.accent,
              title: 'Sign Up',
              onPressed: () => navigationController.navigateTo(
                AppRoutes.appwebview,
                arguments: AppWebViewRouteArgument(
                  title: 'Avatrade Sign up',
                  url: 'https://www.avatrade.com/trading-account?tag=183729',
                  navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                ),
              ),
            ),
            CardButton(
              imagePath: AssetImages.fund,
              backgroundColor: context.colors.primary,
              title: 'Fund Account',
              onPressed: () => navigationController.navigateTo(
                AppRoutes.appwebview,
                arguments: AppWebViewRouteArgument(
                  title: 'Fund Account',
                  url: 'https://myvip.avatrade.com/deposit',
                  navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                ),
              ),
            ),
            CardButton(
              imagePath: AssetImages.copyTrade,
              backgroundColor: context.colors.primary,
              title: 'Copy Trades',
              onPressed: () => navigationController.navigateTo(
                AppRoutes.appwebview,
                arguments: AppWebViewRouteArgument(
                  title: 'Copy Trades',
                  url: 'https://www.duplitrade.com/',
                  navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                ),
              ),
            ),
            CardButton(
              imagePath: AssetImages.download,
              backgroundColor: context.colors.accent,
              title: 'Download MT4',
              onPressed: () => navigationController.navigateTo(
                AppRoutes.appwebview,
                arguments: AppWebViewRouteArgument(
                  title: 'Download MT4',
                  url: 'https://www.avatrade.com/trading-platforms/metatrader-4',
                  navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                ),
              ),
            ),
          ],
        ),
        const AppSpacing(v: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardButton(
              imagePath: AssetImages.download,
              backgroundColor: context.colors.accent,
              title: 'Download MT5',
              onPressed: () => navigationController.navigateTo(
                AppRoutes.appwebview,
                arguments: AppWebViewRouteArgument(
                  title: 'Download MT5',
                  url: 'https://www.avatrade.com/trading-platforms/metatrader-5',
                  navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                ),
              ),
            ),
            CardButton(
              imagePath: AssetImages.signals,
              backgroundColor: context.colors.accent,
              title: 'AI Signals',
              onPressed: () {},
            ),
            CardButton(
              imagePath: AssetImages.services,
              backgroundColor: context.colors.primary,
              title: 'VIP Services',
              onPressed: () {},
            ),
            CardButton(
              imagePath: AssetImages.skills,
              backgroundColor: context.colors.primary,
              title: 'Build Trading Skills',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
