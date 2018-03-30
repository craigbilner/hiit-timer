import 'package:flutter/material.dart';
import 'dart:async';
import 'models.dart';
import 'read_write.dart';
import 'in_play.dart';
import 'ce_workout.dart';

enum WorkoutsPageMode { read, edit, delete }

class WorkoutsPage extends StatefulWidget {
  WorkoutsPage({
    Key key,
    this.mode: WorkoutsPageMode.read,
    this.selectedId,
  });

  final WorkoutsPageMode mode;
  final int selectedId;

  @override
  _WorkoutsPageState createState() => new _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  List<Workout> workouts = [];
  bool isFetching = true;

  _refreshPage() {
    return readWorkouts().then((List<Workout> ws) {
      setState(() {
        isFetching = false;
        workouts = ws;
      });
    });
  }

  _onItemSelected(Workout w) async {
    if (widget.mode == WorkoutsPageMode.edit) {
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
    } else if (widget.mode == WorkoutsPageMode.read) {
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
  }

  _onItemLongPressed(Workout w) async {
    await Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) => new WorkoutsPage(
                mode: WorkoutsPageMode.delete,
              ),
        ));

    _refreshPage();
  }

  @override
  initState() {
    super.initState();

    _refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    Widget leading;

    if (isFetching) {
      body = new FetchingState();
    } else if (workouts.length == 0) {
      body = new EmptyState();
    } else {
      body = new WorkoutsList(
        widget.mode,
        workouts,
        _onItemSelected,
        _onItemLongPressed,
        selectedId: widget.selectedId,
      );
    }

    if (workouts.length == 0) {
      leading = new Container();
    } else if (widget.mode == WorkoutsPageMode.delete) {
      leading = new GestureDetector(
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Icon(
                Icons.delete,
              ),
            ),
            new Text(
              'All',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        onTap: () async {
          await deleteWorkouts(workouts);

          Navigator.of(context).pop();

          _refreshPage();
        },
      );
    } else if (widget.mode == WorkoutsPageMode.edit) {
      leading = new IconButton(
        icon: new Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        color: Colors.white,
        onPressed: () async {
          Navigator.of(context).pop();
        },
      );
    } else {
      leading = new IconButton(
        icon: new Icon(
          Icons.edit,
          color: Colors.white,
        ),
        color: Colors.white,
        onPressed: () async {
          await Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (BuildContext context, _, __) => new WorkoutsPage(
                      mode: WorkoutsPageMode.edit,
                    ),
              ));

          _refreshPage();
        },
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        leading: leading,
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
    this.mode,
    this.workouts,
    this.onTap,
    this.onLongPress, {
    Key key,
    this.selectedId,
  });

  final WorkoutsPageMode mode;
  final List<Workout> workouts;
  final Function onTap;
  final Function onLongPress;
  final int selectedId;

  @override
  Widget build(BuildContext context) {
    Icon trailingIcon;

    if (mode == WorkoutsPageMode.delete) {
      trailingIcon = new Icon(Icons.delete);
    } else if (mode == WorkoutsPageMode.edit) {
      trailingIcon = new Icon(Icons.edit);
    } else {
      trailingIcon = new Icon(
        Icons.arrow_right,
        size: 50.0,
      );
    }

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
                trailing: trailingIcon,
                onTap: () => onTap(w),
                onLongPress: () => onLongPress(w),
              ))
          .toList(),
    );
  }
}
