import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class P2PBettingBottomSheet extends StatefulWidget {
  const P2PBettingBottomSheet({super.key, required this.bet});

  final Bet bet;

  @override
  State<P2PBettingBottomSheet> createState() => _P2PBettingBottomSheetState();
}

class _P2PBettingBottomSheetState extends State<P2PBettingBottomSheet> {
  List<String> score = <String>[];

  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    score = widget.bet.score != null ? widget.bet.score!.split(' ') : '? - ?'.split(' ');
    return Stack(
      children: <Widget>[
        Container(
          padding: AppPaddings.homeH.add(AppPaddings.homeV),
          width: 1.sw,
          height: widget.bet.opponent != null ? 460 : 315,
          child: SingleChildScrollView(
            child: AppAnimatedColumn(
              children: <Widget>[
                const AppSpacing(v: 14),
                _buildTeamRow(context),
                const AppSpacing(v: 16),
                Text(
                  'Creator of Bet',
                  style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                ),
                const AppSpacing(v: 8),
                _buildUserAvatar(widget.bet.creator.user),
                const AppSpacing(v: 8),
                Text(
                  'Creator\'s team',
                  style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                ),
                const AppSpacing(v: 5),
                Text(
                  widget.bet.creator.team,
                  style: context.caption.copyWith(color: context.colors.text, fontWeight: FontWeight.w700),
                ),
                const AppSpacing(v: 8),
                Text(
                  'Creator\'s choice',
                  style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                ),
                const AppSpacing(v: 5),
                Text(
                  StringUtils.capitalizeFirst(widget.bet.creator.choice.stringValue),
                  style: context.caption
                      .copyWith(color: widget.bet.creator.choice.color(context), fontWeight: FontWeight.w700),
                ),
                if (widget.bet.opponent != null) const AppSpacing(v: 16),
                if (widget.bet.opponent != null)
                  Text(
                    'Opponent',
                    style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                  ),
                if (widget.bet.opponent != null) const AppSpacing(v: 8),
                if (widget.bet.opponent != null) _buildUserAvatar(widget.bet.opponent!.user),
                if (widget.bet.opponent != null) const AppSpacing(v: 8),
                if (widget.bet.opponent != null)
                  Text(
                    'Opponent\'s team',
                    style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                  ),
                if (widget.bet.opponent != null) const AppSpacing(v: 5),
                if (widget.bet.opponent != null)
                  Text(
                    widget.bet.opponent!.team,
                    style: context.caption.copyWith(color: context.colors.text, fontWeight: FontWeight.w700),
                  ),
                if (widget.bet.opponent != null) const AppSpacing(v: 8),
                if (widget.bet.opponent != null)
                  Text(
                    'Opponent\'s choice',
                    style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                  ),
                if (widget.bet.opponent != null) const AppSpacing(v: 5),
                if (widget.bet.opponent != null)
                  Text(
                    StringUtils.capitalizeFirst(widget.bet.opponent!.choice.stringValue),
                    style: context.caption
                        .copyWith(color: widget.bet.opponent!.choice.color(context), fontWeight: FontWeight.w700),
                  ),
                const AppSpacing(v: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Date Created',
                      style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w700),
                    ),
                    TimeCard(dateTime: widget.bet.createdAt),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: TextButton(
            onPressed: Navigator.of(context).pop,
            child: Icon(Icons.cancel_rounded, color: context.colors.error),
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar(User user) {
    return Row(
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: NetworkImage(
                '${AppEndpoints.userImages}/${user.photo}',
                headers: <String, String>{
                  'Authorization': 'Bearer ${bController.userToken.value}',
                },
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: context.body2.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(color: context.colors.grey, fontSize: 12),
              ),
              const AppSpacing(v: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Column(
            children: <Widget>[
              MatchAvatar(
                logo: widget.bet.homeTeam.logo,
                selected: true,
                disabled: false,
                backgroundColor: widget.bet.creator.teamId == widget.bet.homeTeam.teamId
                    ? widget.bet.creator.choice.color(context)
                    : widget.bet.opponent?.teamId == widget.bet.homeTeam.teamId
                        ? widget.bet.opponent?.choice.color(context)
                        : context.colors.text,
              ),
              const AppSpacing(v: 8),
              Text(
                widget.bet.homeTeam.name,
                style: TextStyle(color: context.colors.black, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  score.first,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
                ),
                const AppSpacing(h: 5),
                const Text(
                  '-',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const AppSpacing(h: 5),
                Text(
                  score.last,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
                ),
              ],
            ),
            const AppSpacing(v: 8),
            Container(
              padding: AppPaddings.sV.add(AppPaddings.mH),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50), color: widget.bet.status.color(context)),
              child: Center(
                child: Text(
                  widget.bet.status.stringAmount(widget.bet.amount),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    decoration: widget.bet.status == BetStatus.cancelled ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 100,
          child: Column(
            children: <Widget>[
              MatchAvatar(
                logo: widget.bet.awayTeam.logo,
                selected: true,
                disabled: false,
                backgroundColor: widget.bet.creator.teamId == widget.bet.awayTeam.teamId
                    ? widget.bet.creator.choice.color(context)
                    : widget.bet.opponent?.teamId == widget.bet.awayTeam.teamId
                        ? widget.bet.opponent?.choice.color(context)
                        : context.colors.text,
              ),
              const AppSpacing(v: 8),
              Text(
                widget.bet.awayTeam.name,
                style: TextStyle(color: context.colors.black, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
