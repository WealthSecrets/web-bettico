import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, required this.startTime, this.callback});

  final DateTime startTime;
  final VoidCallback? callback;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final DateTime currentTime = DateTime.now();
      if (currentTime.isBefore(widget.startTime)) {
        setState(() {
          _duration = widget.startTime.difference(currentTime);
        });
      } else {
        _timer.cancel();
        widget.callback?.call();
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
    final String formattedDuration =
        '${_duration.inHours}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return Text(
      formattedDuration,
      style: context.caption.copyWith(color: context.colors.primary),
    );
  }
}
