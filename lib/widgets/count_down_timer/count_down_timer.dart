import 'dart:async';
import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../base/texts.dart';

class CountDownTimer extends StatefulWidget {
  final int totalMilliseconds;
  final VoidCallback onFinish;

  const CountDownTimer({
    super.key,
    required this.totalMilliseconds,
    required this.onFinish,
  });

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  int _milliseconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_milliseconds < widget.totalMilliseconds) {
          _milliseconds += 100;
        } else {
          _timer.cancel();
          widget.onFinish();
        }
      });
    });
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds ~/ 1000) ~/ 60; // 计算分钟数
    int remainingSeconds = (milliseconds ~/ 1000) % 60; // 计算剩余的秒数
    int remainingMilliseconds = (milliseconds % 1000) ~/ 10; // 计算剩余的毫秒数

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}:${remainingMilliseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Texts.normal(_formatTime(_milliseconds),
        color: Colours.primaryColor);
  }
}
