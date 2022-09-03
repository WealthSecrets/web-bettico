import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/p2p_betting/data/models/bet/bet.dart';
import 'package:betticos/features/p2p_betting/data/models/bettor/bettor.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/widgets/time_card.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class P2PBettingHistoryCard extends StatelessWidget {
  const P2PBettingHistoryCard({
    Key? key,
    required this.bet,
    this.onPressed,
  }) : super(key: key);

  final Bet bet;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 4).add(
        const EdgeInsets.only(top: 4),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.cardColor,
          width: 1,
        ),
        borderRadius: AppBorderRadius.smallAll,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: ResponsiveWidget.isSmallScreen(context)
              ? const EdgeInsets.symmetric(horizontal: 16)
              : const EdgeInsets.symmetric(vertical: 16).add(
                  const EdgeInsets.symmetric(horizontal: 38),
                ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (bet.date != null)
                    TimeCard(dateTime: DateTime.parse(bet.date!)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8)
                        .add(const EdgeInsets.symmetric(vertical: 4)),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.largeAll,
                      color: bet.status.color(context).withOpacity(.3),
                      border: Border.all(
                        color: bet.status.color(context),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      bet.status.stringValue.toUpperCase(),
                      style: TextStyle(
                        fontSize:
                            ResponsiveWidget.isSmallScreen(context) ? 8 : 10,
                        // fontWeight: FontWeight.w700,
                        fontWeight: ResponsiveWidget.isSmallScreen(context)
                            ? FontWeight.w700
                            : FontWeight.normal,
                        color: bet.status.color(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (bet.awayTeam.logo != null)
                          Container(
                            height: 60,
                            width: 60,
                            padding: AppPaddings.lA,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: bet.creator.teamId == bet.awayTeam.teamId
                                    ? bet.creator.choice.color(context)
                                    : bet.opponent != null
                                        ? bet.opponent!.teamId ==
                                                bet.awayTeam.teamId
                                            ? bet.opponent!.choice
                                                .color(context)
                                            : context.colors.text
                                        : context.colors.text,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  bet.awayTeam.logo!,
                                ),
                                fit: BoxFit.contain,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        SizedBox(
                          height:
                              ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                        ),
                        Text(
                          bet.awayTeam.name,
                          style: TextStyle(
                            color: context.colors.black,
                            fontSize: ResponsiveWidget.isSmallScreen(context)
                                ? 12
                                : 14,
                            fontWeight: ResponsiveWidget.isSmallScreen(context)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 70,
                    child: Column(
                      children: <Widget>[
                        Text(
                          bet.score ?? '? - ?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colors.text,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height:
                              ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                        ),
                        Container(
                          padding: ResponsiveWidget.isSmallScreen(context)
                              ? const EdgeInsets.symmetric(vertical: 4).add(
                                  const EdgeInsets.symmetric(horizontal: 8))
                              : const EdgeInsets.symmetric(vertical: 4).add(
                                  const EdgeInsets.symmetric(horizontal: 16)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: bet.status.color(context),
                          ),
                          child: Center(
                            child: Text(
                              bet.status.stringAmount(bet.amount),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                decoration: bet.status == BetStatus.cancelled
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (bet.homeTeam.logo != null)
                          Container(
                            height: 60,
                            width: 60,
                            padding: AppPaddings.lA,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: bet.creator.teamId == bet.homeTeam.teamId
                                    ? bet.creator.choice.color(context)
                                    : bet.opponent != null
                                        ? bet.opponent!.teamId ==
                                                bet.homeTeam.teamId
                                            ? bet.opponent!.choice
                                                .color(context)
                                            : context.colors.text
                                        : context.colors.text,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  bet.homeTeam.logo!,
                                ),
                                fit: BoxFit.contain,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        SizedBox(
                          height:
                              ResponsiveWidget.isSmallScreen(context) ? 8 : 12,
                        ),
                        Text(
                          bet.homeTeam.name,
                          style: TextStyle(
                            color: context.colors.black,
                            fontWeight: ResponsiveWidget.isSmallScreen(context)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: ResponsiveWidget.isSmallScreen(context)
                                ? 12
                                : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension BetStatusX on BetStatus {
  Color color(BuildContext context) {
    switch (this) {
      case BetStatus.awaiting:
        return context.colors.yellow;
      case BetStatus.ongoing:
        return context.colors.success;
      case BetStatus.completed:
        return context.colors.success;
      case BetStatus.cancelled:
        return context.colors.error;
    }
  }

  String stringAmount(double amount) {
    switch (this) {
      case BetStatus.awaiting:
        return '\$$amount?';
      case BetStatus.ongoing:
        return '\$$amount';
      case BetStatus.cancelled:
        return '\$$amount';
      case BetStatus.completed:
        return '\$$amount';
    }
  }
}

extension BettorChoiceX on BettorChoice {
  Color color(BuildContext context) {
    switch (this) {
      case BettorChoice.win:
        return context.colors.success;
      case BettorChoice.draw:
        return context.colors.yellow;
      case BettorChoice.loss:
        return context.colors.error;
    }
  }
}
