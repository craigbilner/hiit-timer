import 'package:flutter/material.dart';
import 'models.dart';

class Workout {
  Workout(this.name, this.workSets, this.workDuration, this.restDuration);

  final String name;
  final List<WorkSet> workSets;
  final Duration workDuration;
  final Duration restDuration;
}

class WorkoutsPage extends StatelessWidget {
  WorkoutsPage(this.workouts, {Key key}) : super(key: key);

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text('Workouts'),
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
          children: workouts
              .map((Workout w) => new ListTile(
                    title: new Text(w.name),
                    trailing: new Icon(
                      Icons.arrow_right,
                      size: 50.0,
                    ),
                    onTap: () {
                      Navigator.of(context).push(route)
                    },
                  ))
              .toList()),
    );
  }
}
