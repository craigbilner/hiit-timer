import 'package:flutter/material.dart';
import 'workouts.dart';
import 'settings.dart';
import 'ce_workout.dart';
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
      new TimeDuration(
        new Duration(
          seconds: 15,
        ),
      ),
      new TimeDuration(
        new Duration(
          seconds: 15,
        ),
      ),
      workSets,
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
        '/create_workout': (BuildContext context) => new CreateEditWorkoutPage(
              actionName: 'Create',
            ),
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}
