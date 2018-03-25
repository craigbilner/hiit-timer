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
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => new SettingsPage(),
      },
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
  final FontWeight fontWeight = FontWeight.w100;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(title),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new TimerItem(
            initValue: 10,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new RestItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new RepsItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new SetsItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
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
    return new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: new Row(
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
      ),
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
    this.fontWeight: FontWeight.normal,
  });

  final int initValue;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: 'Work',
      subTitle: 'Swing',
      mainItem: new CustomTimer(
        initValue: initValue,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class RestItem extends StatelessWidget {
  RestItem({
    Key key,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        formatTime(7),
        style: new TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
          fontWeight: fontWeight,
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
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '0 / 1',
        style: new TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
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
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '1 / 200',
        style: new TextStyle(
          color: Colors.orange,
          fontSize: fontSize,
          fontWeight: fontWeight,
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

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool fser = false;
  bool ver = false;
  bool pna = false;
  bool frs = false;
  double nps = 0.0;
  double wb = 3.0;
  bool wwb = false;

  final TextStyle labelStyle = new TextStyle(
    fontSize: 20.0,
  );
  final double sliderCountSize = 25.0;
  final double arrowSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text('Settings'),
        ),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        children: <Widget>[
          new ListTile(
            title: new Text(
              'Flash Screen Each Rep',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: fser,
              onChanged: (bool newValue) {
                setState(() {
                  fser = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Vibrate Each Rep',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: ver,
              onChanged: (bool newValue) {
                setState(() {
                  ver = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Preview Next Activity',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: pna,
              onChanged: (bool newValue) {
                setState(() {
                  pna = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Final Rep Sync',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: frs,
              onChanged: (bool newValue) {
                setState(() {
                  frs = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Prep Seconds',
              style: labelStyle,
            ),
            subtitle: new Text(
              nps.toInt().toString(),
              style: new TextStyle(
                fontSize: sliderCountSize,
              ),
            ),
            trailing: new Slider(
              value: nps,
              min: 0.0,
              max: 10.0,
              onChanged: (double newValue) {
                setState(() {
                  nps = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Warning Beeps',
              style: labelStyle,
            ),
            subtitle: new Text(
              wb.toInt().toString(),
              style: new TextStyle(
                fontSize: sliderCountSize,
              ),
            ),
            trailing: new Slider(
              value: wb,
              min: 0.0,
              max: 10.0,
              onChanged: (double newValue) {
                setState(() {
                  wb = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Work Warning Beeps',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: wwb,
              onChanged: (bool newValue) {
                setState(() {
                  wwb = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Sound Chooser',
              style: labelStyle,
            ),
            trailing: new Icon(
              Icons.arrow_right,
              size: arrowSize,
            ),
          ),
          new ListTile(
            title: new Text(
              'Spoken Alerts',
              style: labelStyle,
            ),
            trailing: new Icon(
              Icons.arrow_right,
              size: arrowSize,
            ),
          ),
        ],
      ),
    );
  }
}
