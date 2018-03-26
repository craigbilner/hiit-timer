import 'package:flutter/material.dart';
import 'dart:async';
import 'helpers.dart';

typedef TimerCallback(Timer t);

class CustomTimer extends StatefulWidget {
  CustomTimer({
    Key key,
    this.initValue,
    this.isFrozen: true,
    this.onComplete,
    this.colour: Colors.black,
    this.fontSize: 14.0,
    this.fontWeight,
  })
      : super(key: key);

  final Duration initValue;
  final bool isFrozen;
  final Function onComplete;
  final double fontSize;
  final Color colour;
  final FontWeight fontWeight;

  @override
  _CustomTimerState createState() => new _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int _curTimeInSecs = 0;
  bool _freezeOnNextTick = false;
  Timer countDown;

  void _createCountdown(TimerCallback cb) {
    if (_curTimeInSecs == 0) {
      return;
    }

    const timeout = const Duration(seconds: 1);

    countDown = new Timer.periodic(timeout, cb);
  }

  void _decrementTime(Timer t) {
    setState(() {
      _curTimeInSecs--;

      if (_curTimeInSecs == 0 && widget.onComplete != null) {
        widget.onComplete();
      }

      if (_freezeOnNextTick) {
        _curTimeInSecs = widget.initValue.inSeconds;
        countDown.cancel();
        _freezeOnNextTick = false;
      }
    });
  }

  @override
  initState() {
    super.initState();

    if (widget.initValue != null) {
      _curTimeInSecs = widget.initValue.inSeconds;
    }
  }

  @override
  dispose() {
    super.dispose();

    if (countDown != null) {
      countDown.cancel();
    }
  }

  @override
  didUpdateWidget(CustomTimer previous) {
    super.didUpdateWidget(previous);

    if (previous.isFrozen == true && !widget.isFrozen) {
      _createCountdown(_decrementTime);
    } else if (countDown != null &&
        countDown.isActive &&
        !previous.isFrozen &&
        widget.isFrozen) {
      _freezeOnNextTick = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Text(
          formatTime(
            new Duration(
              seconds: _curTimeInSecs,
            ),
          ),
          style: new TextStyle(
            fontSize: widget.fontSize,
            color: widget.colour,
            fontWeight: widget.fontWeight,
          )),
      onTap: () {
        if (countDown != null && countDown.isActive) {
          countDown.cancel();
        } else if (!widget.isFrozen) {
          _createCountdown(_decrementTime);
        }
      },
    );
  }
}
