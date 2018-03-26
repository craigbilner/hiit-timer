import 'package:flutter/material.dart';
import 'in_play.dart';
import 'settings.dart';

void main() => runApp(new TimerApp());

class TimerApp extends StatelessWidget {
  final List<WorkSet> workSets = <WorkSet>[
    new WorkSet('Swing'),
    new WorkSet('Lunges'),
    new WorkSet('Plank'),
    new WorkSet('Burpees'),
    new WorkSet('Star Jumps'),
    new WorkSet('Mountain Climbers'),
    new WorkSet('V Sits'),
    new WorkSet('Archer Press-ups'),
    new WorkSet('Military Crawl'),
    new WorkSet('Spiderman Press-ups')
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Gym Timer',
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: new InPlayPage(
        title: '15s/15s VO2 Max',
        workDuration: new Duration(seconds: 10),
        restDuration: new Duration(seconds: 7),
        workSets: workSets,
      ),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}
