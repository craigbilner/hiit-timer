import 'package:flutter/material.dart';
import 'dart:async';
import 'helpers.dart';

typedef TimerCallback(Timer t);

class CustomTimer extends StatefulWidget {
  CustomTimer({
    Key key,
    this.initValue: 0,
    this.fontSize: 14.0,
    this.colour: Colors.green,
    this.fontWeight,
  })
      : super(key: key);

  final int initValue;
  final double fontSize;
  final Color colour;
  final FontWeight fontWeight;

  @override
  _CustomTimerState createState() => new _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int _curTimeInSecs = 0;
  Timer countDown;

  void _createCountdown(TimerCallback cb) {
    const timeout = const Duration(seconds: 1);

    countDown = new Timer.periodic(timeout, cb);
  }

  void _decrementTime(Timer t) {
    setState(() {
      _curTimeInSecs--;

      if (_curTimeInSecs == -1) {
        countDown.cancel();
        _curTimeInSecs = widget.initValue;
      }
    });
  }

  @override
  initState() {
    super.initState();

    _curTimeInSecs = widget.initValue;
  }

  @override
  dispose() {
    super.dispose();

    if (countDown != null) {
      countDown.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Text(formatTime(_curTimeInSecs),
          style: new TextStyle(
            fontSize: widget.fontSize,
            color: widget.colour,
            fontWeight: widget.fontWeight,
          )),
      onTap: () {
        if (countDown != null && countDown.isActive) {
          countDown.cancel();
        } else {
          _createCountdown(_decrementTime);
        }
      },
    );
  }
}
