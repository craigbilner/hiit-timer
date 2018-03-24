import 'package:flutter/material.dart';

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
      body: new Timer(),
    );
  }
}

class Timer extends StatefulWidget {
  Timer({
    Key key,
    this.initValue: 0,
  })
      : super(key: key);

  final int initValue;

  @override
  _TimerState createState() => new _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return new Text(
      widget.initValue.toString(),
    );
  }
}
