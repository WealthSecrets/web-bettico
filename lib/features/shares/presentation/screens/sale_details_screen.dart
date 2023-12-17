import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/shares/presentation/screens/notifications_screen.dart';
import 'package:betticos/features/shares/presentation/widgets/count_down_timer.dart';
import 'package:betticos/features/shares/presentation/widgets/sale_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'contribute_screen.dart';

class SaleDetailsScreenRouteArgument {
  const SaleDetailsScreenRouteArgument({required this.value});

  final dynamic value;
}

class SaleDetailsScreen extends StatefulWidget {
  const SaleDetailsScreen({super.key, required this.value});
  final dynamic value;

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen> {
  final WalletController wController = Get.find<WalletController>();
  String saleTimerText = '';

  @override
  void initState() {
    final String saleId = '${widget.value[0]}';
    wController.getSale(saleId);
    wController.getContributionsBySale(saleId);
    wController.getContributionByUserAndSale(saleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sale Details',
          style: context.sub2.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(
        () {
          final String saleId = '${wController.sale[0]}';
          final double totalSharesRaised = int.parse('${wController.sale[3]}') / weiMultiplier;
          final double totalSubscriptionsRaised = int.parse('${wController.sale[4]}') / weiMultiplier;
          final double targetAmount = int.parse('${wController.sale[2]}') / weiMultiplier;
          final double totalSharesRaisedInUSD = totalSharesRaised * fakeUSD;
          final double totalSubscriptionsRaisedUSD = totalSubscriptionsRaised * fakeUSD;
          final double targetAmountInUSD = targetAmount * fakeUSD;

          final double sharePrice = int.parse('${wController.sale[7]}') / weiMultiplier;
          final double sharePriceUSD = sharePrice * fakeUSD;

          final double subscriptionPrice = int.parse('${wController.sale[8]}') / weiMultiplier;
          final double subscriptionPriceUSD = subscriptionPrice * fakeUSD;

          final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${wController.sale[5]}') * 1000);
          final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${wController.sale[6]}') * 1000);

          // fetch contributions for this sale
          // get user's contribution based on this sale.
          final DateTime now = DateTime.now();
          SalesStatus status = now.isBefore(startTime)
              ? SalesStatus.notstarted
              : now.isAfter(endTime)
                  ? SalesStatus.ended
                  : SalesStatus.live;

          saleTimerText = status == SalesStatus.notstarted
              ? 'Sales Starts In'
              : status == SalesStatus.live
                  ? 'Sales Ends In'
                  : 'Sales Closed';

          // Get Contributions
          final List<dynamic> contributions = wController.saleContributions;
          final double uContribution = int.parse('${wController.userSaleContribution[3]}') / weiMultiplier;
          final double uContributionUSD = uContribution * fakeUSD;
          final int uShares = int.parse('${wController.userSaleContribution[4]}');

          return AppLoadingBox(
            loading: wController.isLoading.value,
            child: Padding(
              padding: AppPaddings.lH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              style:
                                  context.caption.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Sale ID: $saleId',
                              maxLines: 1,
                              style: context.overline.copyWith(color: context.colors.text, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      const AppSpacing(h: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            saleTimerText,
                            style:
                                context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                          ),
                          if (status == SalesStatus.notstarted)
                            CountdownTimer(
                              startTime: startTime,
                              callback: () {
                                setState(() {
                                  saleTimerText = 'Sales Ends In';
                                  status = SalesStatus.live;
                                });
                              },
                            ),
                          if (status == SalesStatus.live)
                            CountdownTimer(
                              startTime: endTime,
                              callback: () {
                                setState(() {
                                  saleTimerText = 'Sales Closed';
                                  status = SalesStatus.ended;
                                });
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                  const AppSpacing(v: 8),
                  const Divider(color: Color(0xFFE3E5E6)),
                  const AppSpacing(v: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'General Information',
                        style: context.sub2.copyWith(fontWeight: FontWeight.bold, color: context.colors.textDark),
                      ),
                      SaleStatusChip(status: status),
                    ],
                  ),
                  const AppSpacing(v: 16),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum facilisis mi eget ex consectetur, ac euismod nisl varius. Phasellus ornare diam vitae justo volutpat, a tincidunt elit vulputate. Quisque vestibulum congue laoreet. Vivamus fringilla porttitor nibh, quis pharetra odio interdum in. Nunc elementum justo a efficitur interdum. Phasellus facilisis non ante vel lacinia. Sed venenatis massa ipsum, sed consectetur ipsum eleifend ac. Phasellus at maximus lacus, cursus malesuada nisl',
                    style: context.caption.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  const AppSpacing(v: 32),
                  Text(
                    'Progress',
                    style: context.sub2.copyWith(fontWeight: FontWeight.bold, color: context.colors.textDark),
                  ),
                  const AppSpacing(v: 5),
                  StepProgressIndicator(
                    totalSteps: targetAmountInUSD.toInt(),
                    currentStep: totalSharesRaisedInUSD.toInt(),
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
                        '${totalSharesRaised.toStringAsFixed(6)} ETH',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: context.colors.textDark,
                        ),
                      ),
                      Text(
                        '${targetAmount.toStringAsFixed(6)} ETH',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: context.colors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 24),
                  _InfoDisplayer(title: 'Target Amount', ethAmount: targetAmount, usdAmount: targetAmountInUSD),
                  const AppSpacing(v: 8),
                  _InfoDisplayer(title: 'Share Price', ethAmount: sharePrice, usdAmount: sharePriceUSD),
                  const AppSpacing(v: 8),
                  _InfoDisplayer(
                      title: 'Subcription Price', ethAmount: subscriptionPrice, usdAmount: subscriptionPriceUSD),
                  const AppSpacing(v: 8),
                  _InfoDisplayer(
                    title: 'Total Contributions',
                    ethAmount: totalSharesRaised + totalSubscriptionsRaised,
                    usdAmount: totalSharesRaisedInUSD + totalSubscriptionsRaisedUSD,
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.notifications,
                      arguments: NotificationsScreenRouteArgument(contributions: contributions),
                    ),
                  ),
                  _InfoDisplayer(
                    title: 'Your Contribution',
                    ethAmount: uContribution,
                    usdAmount: uContributionUSD,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AppButton(
                            enabled: status != SalesStatus.notstarted,
                            padding: AppPaddings.sA,
                            borderRadius: AppBorderRadius.largeAll,
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(AppRoutes.contribute,
                                  arguments: ContributeScreenRouteArgument(sale: wController.sale));
                            },
                            child: Text(
                              status == SalesStatus.ended ? 'purchase'.toUpperCase() : 'contribute'.toUpperCase(),
                              style: context.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const AppSpacing(h: 24),
                        Expanded(
                          child: AppButton(
                            enabled: uShares > 0,
                            padding: AppPaddings.sA,
                            borderRadius: AppBorderRadius.largeAll,
                            onPressed: () => WidgetUtils.showWithdrawSharesModal(
                              context,
                              saleId: saleId,
                              shares: uShares,
                              sharePrice: sharePrice,
                              sharePriceUSD: sharePriceUSD,
                            ),
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
                  const AppSpacing(v: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoDisplayer extends StatelessWidget {
  const _InfoDisplayer({
    required this.title,
    required this.ethAmount,
    required this.usdAmount,
    this.onTap,
  });

  final String title;
  final double ethAmount;
  final double usdAmount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 56,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: context.caption.copyWith(fontWeight: FontWeight.bold, color: context.colors.black),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${ethAmount.toStringAsFixed(6)} ETH',
                          style: context.caption.copyWith(color: context.colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${usdAmount.toStringAsFixed(2)} USD',
                          style: context.caption.copyWith(color: context.colors.primary, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null) ...<Widget>[
                    const AppSpacing(h: 5),
                    Icon(Ionicons.chevron_forward, color: context.colors.text, size: 24)
                  ],
                ],
              ),
            ),
            const Divider(color: Color(0xFFE3E5E6), height: 10),
          ],
        ),
      ),
    );
  }
}
