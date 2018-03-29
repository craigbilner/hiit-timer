import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'workouts.dart';
import 'settings.dart';
import 'ce_workout.dart';
import 'models.dart';

void main() => runApp(new TimerApp());

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => new _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  List<Workout> workouts;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return new File('$path/workouts.txt');
  }

  Future<Workout> _readWorkouts() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      Map m = json.decode(contents);

      return new Workout.fromJson(m);
    } catch (e) {
      // If we encounter an error, return 0
      return null;
    }
  }

  @override
  initState() {
    super.initState();

    final workout = _readWorkouts();

    workouts = [workout];
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
