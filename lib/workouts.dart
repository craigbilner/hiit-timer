import 'package:flutter/material.dart';
import 'dart:async';
import 'models.dart';
import 'read_write.dart';
import 'in_play.dart';
import 'ce_workout.dart';

class WorkoutsPage extends StatefulWidget {
  WorkoutsPage({
    Key key,
    this.isEditing: false,
  });

  final bool isEditing;

  @override
  _WorkoutsPageState createState() => new _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  List<Workout> workouts = [];
  bool isFetching = true;

  _refreshPage() {
    readWorkouts().then((List<Workout> ws) {
      setState(() {
        isFetching = false;
        workouts = ws;
      });
    });
  }

  @override
  initState() {
    super.initState();

    _refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (isFetching) {
      body = new FetchingState();
    } else if (workouts.length == 0) {
      body = new EmptyState();
    } else {
      body = new WorkoutsList(
        workouts,
        isEditing: widget.isEditing,
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: widget.isEditing
              ? new Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )
              : new Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
          color: Colors.white,
          onPressed: () async {
            if (widget.isEditing) {
              Navigator.of(context).pop();
            } else {
              await Navigator.of(context).push(new PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) =>
                        new WorkoutsPage(
                          isEditing: true,
                        ),
                  ));

              _refreshPage();
            }
          },
        ),
        title: new Text('Workouts'),
        centerTitle: true,
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
        onPressed: () async {
          await Navigator.of(context).pushNamed('/create_workout');

          _refreshPage();
        },
        child: new Icon(
          Icons.add,
        ),
      ),
      body: body,
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

class FetchingState extends StatefulWidget {
  @override
  _FetchingStateState createState() => new _FetchingStateState();
}

class _FetchingStateState extends State<FetchingState> {
  Timer countdown;
  bool showLoader = false;

  @override
  initState() {
    super.initState();

    const timeout = const Duration(milliseconds: 200);

    countdown = new Timer(timeout, () {
      setState(() {
        showLoader = true;
      });
    });
  }

  @override
  dispose() {
    super.dispose();

    countdown.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return showLoader
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : new Container();
  }
}

class WorkoutsList extends StatelessWidget {
  WorkoutsList(
    this.workouts, {
    Key key,
    this.isEditing: false,
  });

  final List<Workout> workouts;
  final bool isEditing;

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
                trailing: isEditing
                    ? new Icon(Icons.edit)
                    : new Icon(
                        Icons.arrow_right,
                        size: 50.0,
                      ),
                onTap: () async {
                  if (isEditing) {
                    await Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext bc) => new EditWorkoutPage(
                                  w.id,
                                  workoutName: w.name,
                                  workDuration: w.workDuration,
                                  restDuration: w.restDuration,
                                  workSets: w.workSets,
                                ),
                          ),
                        );

                    Navigator.of(context).pop();
                  } else {
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
                  }
                },
              ))
          .toList(),
    );
  }
}
