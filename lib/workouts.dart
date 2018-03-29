import 'package:flutter/material.dart';
import 'models.dart';
import 'in_play.dart';

class WorkoutsPage extends StatelessWidget {
  WorkoutsPage(
    this.workouts, {
    Key key,
  }) : super(key: key);

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
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/create_workout'),
        child: new Icon(
          Icons.add,
        ),
      ),
      body:
          workouts.length == 0 ? new EmptyState() : new WorkoutsList(workouts),
    );
  }
}

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            'You haven\'t created any workouts! Click the add button below to start',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutsList extends StatelessWidget {
  WorkoutsList(this.workouts, {Key key});

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      children: workouts
          .map((Workout w) => new ListTile(
                title: new Text(
                  w.name,
                  style: new TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                trailing: new Icon(
                  Icons.arrow_right,
                  size: 50.0,
                ),
                onTap: () {
                  Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext bc) => new InPlayPage(
                                title: w.name,
                                workDuration: w.workDuration,
                                restDuration: w.restDuration,
                                workSets: w.workSets,
                              ),
                        ),
                      );
                },
              ))
          .toList(),
    );
  }
}
