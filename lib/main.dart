import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Gym Timer',
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: new InPlayPage(
        title: '15s/15s VO2 Max',
      ),
    );
  }
}

class InPlayPage extends StatelessWidget {
  InPlayPage({
    Key key,
    this.title,
  })
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(title),
        ),
      ),
      body: new CustomTimer(
        initValue: 10,
        fontSize: 100.0,
      ),
    );
  }
}

class CustomTimer extends StatefulWidget {
  CustomTimer({Key key, this.initValue: 0, this.fontSize: 14.0})
      : super(key: key);

  final int initValue;
  final double fontSize;

  @override
  _CustomTimerState createState() => new _CustomTimerState();
}

typedef TimerCallback(Timer t);

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

  String _toTwoDigits(int num) {
    if (num < 10) {
      return '0$num';
    }

    return num.toString();
  }

  String _formatTime(int curTimeInSecs) {
    final int _mins = curTimeInSecs ~/ 60;
    final int _secs = curTimeInSecs - (_mins * 60);
    final String mins = _toTwoDigits(_mins);
    final String secs = _toTwoDigits(_secs);

    return '$mins:$secs';
  }

  @override
  initState() {
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
      child: new Text(_formatTime(_curTimeInSecs),
          style: new TextStyle(
            fontSize: widget.fontSize,
            color: Colors.lightGreen,
            fontWeight: FontWeight.w100,
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
