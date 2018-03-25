import 'package:flutter/material.dart';
import 'in_play.dart';
import 'settings.dart';

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
        activity: 'Swing',
        workDuration: new Duration(seconds: 10),
        restDuration: new Duration(seconds: 7),
      ),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}
