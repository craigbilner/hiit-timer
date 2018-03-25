import 'package:flutter/foundation.dart';
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
  final double fontSize = 75.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(title),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new TimerItem(
            initValue: 10,
            fontSize: fontSize,
          ),
          new RestItem(
            fontSize: fontSize,
          ),
          new RepsItem(
            fontSize: fontSize,
          ),
          new SetsItem(
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    Key key,
    @required this.mainItem,
    @required this.title,
    this.subTitle: '',
  })
      : super(key: key);

  final Widget mainItem;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 150.0,
          padding: const EdgeInsets.all(32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                title,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              new Text(
                subTitle,
                style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        new Expanded(
          child: mainItem,
        )
      ],
    );
  }
}

String toTwoDigits(int num) {
  if (num < 10) {
    return '0$num';
  }

  return num.toString();
}

String formatTime(int curTimeInSecs) {
  final int _mins = curTimeInSecs ~/ 60;
  final int _secs = curTimeInSecs - (_mins * 60);
  final String mins = toTwoDigits(_mins);
  final String secs = toTwoDigits(_secs);

  return '$mins:$secs';
}

class TimerItem extends StatelessWidget {
  TimerItem({
    Key key,
    this.initValue: 0,
    this.fontSize: 20.0,
  });

  final int initValue;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: 'Work',
      subTitle: 'Swing',
      mainItem: new CustomTimer(
        initValue: initValue,
        fontSize: fontSize,
      ),
    );
  }
}

class RestItem extends StatelessWidget {
  RestItem({
    Key key,
    this.fontSize: 20.0,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        formatTime(7),
        style: new TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
        ),
      ),
      title: 'Rest',
    );
  }
}

class RepsItem extends StatelessWidget {
  RepsItem({
    Key key,
    this.fontSize: 20.0,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '0 / 1',
        style: new TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
      title: 'Reps',
      subTitle: 'Interval',
    );
  }
}

class SetsItem extends StatelessWidget {
  SetsItem({
    Key key,
    this.fontSize: 20.0,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '1 / 200',
        style: new TextStyle(
          color: Colors.orange,
          fontSize: fontSize,
        ),
      ),
      title: 'Sets',
    );
  }
}

class CustomTimer extends StatefulWidget {
  CustomTimer({
    Key key,
    this.initValue: 0,
    this.fontSize: 14.0,
  })
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
