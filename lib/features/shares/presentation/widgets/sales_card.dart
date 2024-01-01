import 'package:betticos/core/core.dart';
import 'package:betticos/features/shares/presentation/widgets/count_down_timer.dart';
import 'package:betticos/features/shares/presentation/widgets/sale_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SalesCard extends StatefulWidget {
  const SalesCard({super.key, required this.value, this.onPressed});

  final dynamic value;
  final VoidCallback? onPressed;

  @override
  State<SalesCard> createState() => _SalesCardState();
}

class _SalesCardState extends State<SalesCard> {
  String saleTimerText = '';

  @override
  Widget build(BuildContext context) {
    final String saleId = '${widget.value[0]}';
    final double totalSharesRaised = int.parse('${widget.value[3]}') / weiMultiplier;
    final double targetAmount = int.parse('${widget.value[2]}') / weiMultiplier;
    final int totalSharesRaisedInUSD = (totalSharesRaised * fakeUSD).toInt();
    final int targetAmountInUSD = (targetAmount * fakeUSD).toInt();

    final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${widget.value[5]}') * 1000);
    final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${widget.value[6]}') * 1000);

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

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
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
                        'Sale ID: $saleId',
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
                      saleTimerText,
                      style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
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
            StepProgressIndicator(
              totalSteps: targetAmountInUSD,
              currentStep: totalSharesRaisedInUSD,
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
                  '${totalSharesRaised.toStringAsFixed(2)} ETH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: context.colors.textDark,
                  ),
                ),
                Text(
                  '${targetAmount.toStringAsFixed(2)} ETH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: context.colors.textDark,
                  ),
                ),
              ],
            ),
            const AppSpacing(v: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'End Date: ',
                    style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: Moment(endTime).calendar(),
                        style: context.caption.copyWith(color: context.colors.primary.shade700),
                      )
                    ],
                  ),
                ),
                SaleStatusChip(status: status)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
