import 'package:flutter/material.dart';
import 'workouts.dart';
import 'settings.dart';
import 'ce_workout.dart';
import 'models.dart';
import 'read_write.dart';

void main() => runApp(new TimerApp());

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => new _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  List<Workout> workouts = [];

  @override
  initState() {
    super.initState();

    readWorkouts().then((List<Workout> ws) {
      setState(() {
        workouts = ws;
      });
    });
  }

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
