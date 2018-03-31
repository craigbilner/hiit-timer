import 'package:flutter/material.dart';
import 'dart:async';
import 'models.dart';
import 'read_write.dart';
import 'in_play.dart';
import 'ce_workout.dart';
import 'app_bar.dart';

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
  List<int> selectedIds = [];
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
                selectedId: w.id,
              ),
        ));

    _refreshPage();
  }

  _onItemSelectionChange({
    Workout workout,
    bool isSelected,
  }) {
    setState(() {
      if (!isSelected) {
        selectedIds.removeWhere((int id) => id == workout.id);
      } else {
        selectedIds.add(workout.id);
      }
    });
  }

  @override
  initState() {
    super.initState();

    if (widget.selectedId != null) {
      selectedIds.add(widget.selectedId);
    }

    _refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    Widget leading;
    List<Widget> actions;

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
        selectedIds: selectedIds,
        onItemSelectionChange: _onItemSelectionChange,
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
          setState(() {
            selectedIds = workouts.map((w) => w.id).toList();
          });
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

    if (widget.mode == WorkoutsPageMode.read) {
      actions = [
        new IconButton(
          icon: new Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).pushNamed('/settings');
          },
        )
      ];
    } else if (widget.mode == WorkoutsPageMode.delete) {
      actions = [
        new ActionButton(
          text: 'Delete',
          onPressed: () async {
            await deleteWorkouts(selectedIds);

            Navigator.of(context).pop();

            _refreshPage();
          },
        )
      ];
    }

    return new Scaffold(
      appBar: new AppBar(
        leading: leading,
        title: new Text('Workouts'),
        centerTitle: true,
        actions: actions,
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
    this.selectedIds,
    this.onItemSelectionChange,
  });

  final WorkoutsPageMode mode;
  final List<Workout> workouts;
  final Function onTap;
  final Function onLongPress;
  final List<int> selectedIds;
  final Function onItemSelectionChange;

  _trailing(Workout w) {
    if (mode == WorkoutsPageMode.delete) {
      return new Checkbox(
        value: selectedIds.contains(w.id),
        onChanged: (bool isSelected) {
          if (onItemSelectionChange != null) {
            onItemSelectionChange(
              workout: w,
              isSelected: isSelected,
            );
          }
        },
      );
    } else if (mode == WorkoutsPageMode.edit) {
      return new Icon(Icons.edit);
    } else {
      return new Icon(
        Icons.arrow_right,
        size: 50.0,
      );
    }
  }

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
                trailing: _trailing(w),
                onTap: () => onTap(w),
                onLongPress: () => onLongPress(w),
              ))
          .toList(),
    );
  }
}
