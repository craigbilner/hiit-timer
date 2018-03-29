import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'models.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;

  return new File('$path/workouts.txt');
}

Future<List<Workout>> readWorkouts() async {
  try {
    final file = await _localFile;

    String contents = await file.readAsString();

    return new Workouts.fromJson(json.decode(contents)).workouts;
  } catch (e) {
    print('error: $e');

    return [];
  }
}

Future<File> writeWorkout(Workout w) async {
  List<Workout> existingWorkouts = await readWorkouts();

  if (existingWorkouts != null && existingWorkouts.length > 0) {
    existingWorkouts.add(w);
  } else {
    existingWorkouts = [w];
  }

  final file = await _localFile;

  return file.writeAsString(
    json.encode(
      new Workouts(
        existingWorkouts,
      ),
    ),
  );
}
