import 'package:flutter/material.dart';
import 'workouts.dart';
import 'settings.dart';
import 'ce_workout.dart';

void main() => runApp(new TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HIIT Timer',
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: new WorkoutsPage(),
      routes: <String, WidgetBuilder>{
        '/create_workout': (BuildContext context) => new CreateEditWorkoutPage(
              actionName: 'Create',
            ),
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}
