import 'package:flutter/material.dart';
import 'workouts.dart';
import 'settings.dart';
import 'create_workout.dart';
import 'models.dart';

void main() => runApp(new TimerApp());

class TimerApp extends StatelessWidget {
  static final List<WorkSet> workSets = <WorkSet>[
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

  final List<Workout> workouts = <Workout>[
    new Workout(
      '15s/15s VO2 Max',
      workSets,
      new Duration(seconds: 15),
      new Duration(seconds: 15),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HIIT Timer',
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: new WorkoutsPage(workouts),
      routes: <String, WidgetBuilder>{
        '/add_workout': (BuildContext context) => new CreateWorkoutPage(),
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}
