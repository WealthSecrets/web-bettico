import 'dart:async';

import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CryptoFrontScreen extends StatefulWidget {
  const CryptoFrontScreen({super.key});

  @override
  State<CryptoFrontScreen> createState() => _CryptoFrontScreenState();
}

class _CryptoFrontScreenState extends State<CryptoFrontScreen> {
  final OkxController controller = Get.find<OkxController>();

  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    final User user = Get.find<BaseScreenController>().user.value;
    WidgetUtils.onWidgetDidBuild(() {
      if (user.okx != null && user.apiKey != null) {
        controller.getUserOkxAccount(context);
        controller.getBalances(context);
        _timer = Timer.periodic(const Duration(milliseconds: 10000), (_) {
          controller.getBalances(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final User user = Get.find<BaseScreenController>().user.value;
          return user.okx == null
              ? NoTradignAccount(user: user)
              : user.apiKey == null
                  ? NoTradingApiKey()
                  : DefaultTabController(
                      length: 3,
                      child: NestedScrollView(
                        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
                          return <Widget>[
                            Obx(
                              () => _SliverAppBar(
                                total: controller.totalBalance.value,
                                tradeName: controller.myOkxAccount.value.subAccount,
                              ),
                            ),
                            SliverPersistentHeader(
                              delegate: _SliverAppBarDelegate(
                                TabBar(
                                  indicatorColor: context.colors.primary,
                                  labelColor: Colors.black,
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                                  padding: AppPaddings.lH,
                                  unselectedLabelColor: Colors.grey,
                                  indicator: CircleTabIndicator(
                                    color: context.colors.primary,
                                    radius: 3,
                                  ),
                                  tabs: const <Tab>[
                                    Tab(text: 'Tokens'),
                                    Tab(text: 'Xviral Pay'),
                                    Tab(text: 'NFTs'),
                                  ],
                                ),
                              ),
                              pinned: true,
                            ),
                          ];
                        },
                        body: const TabBarView(
                          children: <Widget>[
                            TokenScreen(),
                            Center(child: Text('Xviral Pay')),
                            Center(child: Text('NFTs')),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({required this.total, required this.tradeName});

  final String total;
  final String tradeName;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Ionicons.close_outline, color: Colors.black, size: 24),
      ),
      flexibleSpace: _FlexibleSpaceBar(total: total, tradeName: tradeName),
    );
  }
}

class _FlexibleSpaceBar extends StatelessWidget {
  const _FlexibleSpaceBar({required this.total, required this.tradeName});

  final String total;
  final String tradeName;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        padding: AppPaddings.lH.add(AppPaddings.lB),
        decoration: BoxDecoration(color: context.colors.lightGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 32),
            Text(
              '\$${total.isEmpty ? 0.0 : total}',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Align(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _onCopy(context),
                    child: Text(
                      tradeName,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.text),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    child: const Icon(Ionicons.copy_sharp, size: 14),
                    onTap: () => _onCopy(context),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _CryptoIconText(
                  iconData: Ionicons.swap_horizontal_sharp,
                  title: 'Swap',
                  onPressed: () => navigationController.navigateTo(AppRoutes.convertCrypto),
                ),
                _CryptoIconText(
                  iconData: Ionicons.cash_sharp,
                  title: 'Buy/Sell',
                  onPressed: () => navigationController.navigateTo(AppRoutes.buySellCrypto),
                ),
                _CryptoIconText(
                  iconData: Ionicons.qr_code_sharp,
                  title: 'Receive',
                  onPressed: () => navigationController.navigateTo(AppRoutes.currencies),
                ),
                _CryptoIconText(
                  iconData: Ionicons.send_sharp,
                  title: 'Send',
                  onPressed: () => navigationController.navigateTo(AppRoutes.send),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: tradeName));

    AppSnacks.show(
      context,
      message: 'Trade name copied to clipboard',
      backgroundColor: context.colors.success,
      leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, size: 20, color: Colors.white),
    );
  }
}

class _CryptoIconText extends StatelessWidget {
  const _CryptoIconText({required this.iconData, required this.title, required this.onPressed});

  final IconData iconData;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CryptoIcon(iconData: iconData, onPressed: onPressed),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.grey),
        ),
      ],
    );
  }
}

class _CryptoIcon extends StatelessWidget {
  const _CryptoIcon({required this.iconData, required this.onPressed});

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 40, maxWidth: 75),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Center(child: Icon(iconData, size: 24, color: Colors.black)),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(color: Colors.white, child: _tabBar);
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
