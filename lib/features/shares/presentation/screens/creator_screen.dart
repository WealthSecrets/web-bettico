import 'package:betticos/common/common.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorScreen extends StatefulWidget {
  const CreatorScreen({super.key});

  @override
  State<CreatorScreen> createState() => _CreatorScreenState();
}

class _CreatorScreenState extends State<CreatorScreen> {
  WalletController controller = Get.find<WalletController>();
  BaseScreenController baseController = Get.find<BaseScreenController>();
  @override
  void initState() {
    super.initState();
    controller.walletInit((String wallet) {
      controller.getCreatorBalance();
      controller.getTotalSubscriptionRaisedByCreator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final double balance = double.parse(controller.creatorBalance.value);
        return Scaffold(
          appBar: AppBar(
            leading: const AppBackButton(color: Colors.black),
            title: Text(
              'Creator Information',
              style: context.caption.copyWith(color: context.colors.textDark),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _TopRow(controller: controller, baseController: baseController),
                Divider(color: context.colors.faintGrey),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _ClickCard(title: '${controller.creatorBalance.value} Eth', subtitle: 'Fees Earned'),
                      ),
                      const AppSpacing(h: 16),
                      Expanded(
                        child: _ClickCard(
                          title: '${controller.creatorSubscriptoinRaised.value} ETH',
                          subtitle: 'Subcriptions Raised',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Divider(color: context.colors.faintGrey),
                const SizedBox(height: 100),
                Container(
                  height: 60,
                  padding: AppPaddings.lH,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: AppButton(
                          padding: AppPaddings.sA,
                          borderRadius: AppBorderRadius.largeAll,
                          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.createShares),
                          child: Text(
                            'Create New Sale'.toUpperCase(),
                            style: context.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const AppSpacing(h: 24),
                      Expanded(
                        child: AppButton(
                          enabled: balance > 0,
                          padding: AppPaddings.sA,
                          borderRadius: AppBorderRadius.largeAll,
                          onPressed: () => WidgetUtils.showWithdrawBalanceModal(context),
                          backgroundColor: context.colors.error,
                          child: Text(
                            'withdraw'.toUpperCase(),
                            style: context.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ClickCard extends StatelessWidget {
  const _ClickCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: context.colors.faintGrey),
        borderRadius: AppBorderRadius.card,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: context.sub2.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: context.caption.copyWith(color: context.colors.text),
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow({required this.controller, required this.baseController});

  final WalletController controller;
  final BaseScreenController baseController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Color mainColor = controller.isConnected ? context.colors.success : context.colors.primary;
        final Color subColor =
            controller.isConnected ? context.colors.success.withOpacity(0.3) : context.colors.primary.shade100;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Avatar(
                      imageUrl:
                          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    ),
                    const AppSpacing(h: 8),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '@${baseController.user.value.username}',
                            style:
                                context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.walletAddress.value.isNotEmpty
                                ? controller.walletAddress.value
                                : 'wallet not connected',
                            style: context.caption.copyWith(color: context.colors.text),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppSpacing(h: 8),
              GestureDetector(
                onTap: () {
                  if (!controller.isConnected) {
                    controller.walletInit((String wallet) {
                      controller.getCreatorBalance();
                    });
                  } else {
                    controller.disconnect();
                  }
                },
                child: Container(
                  padding: AppPaddings.sV.add(AppPaddings.mH),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor),
                    color: subColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        controller.isConnected ? AssetImages.metamaskLogo : AssetImages.wallet,
                        height: 20,
                        width: 20,
                        color: controller.isConnected ? null : context.colors.primary,
                      ),
                      const AppSpacing(h: 5),
                      Text(
                        controller.isConnected
                            ? '${controller.walletBalance.value} ETH ${controller.walletAddress.substring(0, 5)}...'
                            : 'Connect Wallet',
                        style: context.sub2.copyWith(color: mainColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
