import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app_bar.dart';
import 'edit_time.dart';
import 'edit_text.dart';
import 'ce_sets.dart';
import 'models.dart';
import 'read_write.dart';

enum _PageMode { create, edit }

class CreateWorkoutPage extends StatelessWidget {
  CreateWorkoutPage({
    Key key,
  });

  @override
  Widget build(BuildContext context) {
    return new _CreateEditWorkoutPage(
      _PageMode.create,
    );
  }
}

class EditWorkoutPage extends StatelessWidget {
  EditWorkoutPage(
    this.id, {
    Key key,
    this.workoutName,
    this.workDuration,
    this.restDuration,
    this.workSets,
  });

  final int id;
  final String workoutName;
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;

  @override
  Widget build(BuildContext context) {
    return new _CreateEditWorkoutPage(
      _PageMode.edit,
      id: id,
      workoutName: workoutName,
      workDuration: workDuration,
      restDuration: restDuration,
      workSets: workSets,
    );
  }
}

class _CreateEditWorkoutPage extends StatefulWidget {
  _CreateEditWorkoutPage(
    this.pageState, {
    Key key,
    this.id,
    this.workoutName,
    this.workDuration,
    this.restDuration,
    this.workSets,
  });

  final int id;
  final _PageMode pageState;
  final String workoutName;
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;

  @override
  _CreateEditWorkoutPageState createState() =>
      new _CreateEditWorkoutPageState();
}

class _CreateEditWorkoutPageState extends State<_CreateEditWorkoutPage> {
  String workoutName;
  TimeDuration workDuration;
  TimeDuration restDuration;
  List<WorkSet> workSets;

  _onNameChange(String newName) {
    if (newName != null) {
      workoutName = newName;
    }
  }

  _onWorkDurationChange(TimeDuration wd) {
    if (wd != null) {
      workDuration = wd;
    }
  }

  _onRestDurationChange(TimeDuration rd) {
    if (rd != null) {
      restDuration = rd;
    }
  }

  _onWorkSetsChange(List<WorkSet> wss) {
    if (wss != null) {
      workSets = wss;
    }
  }

  @override
  initState() {
    super.initState();

    final TimeDuration defaultDuration = new TimeDuration(
      new Duration(
        seconds: 15,
      ),
    );

    workoutName =
        widget.workoutName == null ? 'New Workout' : widget.workoutName;
    workDuration =
        widget.workDuration == null ? defaultDuration : widget.workDuration;
    restDuration =
        widget.restDuration == null ? defaultDuration : widget.restDuration;
    workSets = widget.workSets == null ? [] : widget.workSets;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new ActionButton(
            text:
                widget.pageState == _PageMode.create ? 'Create' : 'Save',
            onPressed: () async {
              if (widget.pageState == _PageMode.create) {
                await addWorkout(new Workout(
                  workoutName,
                  workDuration,
                  restDuration,
                  workSets,
                ));
              } else {
                await updateWorkout(
                  widget.id,
                  workoutName: workoutName,
                  workDuration: workDuration,
                  restDuration: restDuration,
                  workSets: workSets,
                );
              }

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: new CreateEditWorkoutForm(
        workoutName,
        workDuration,
        restDuration,
        workSets,
        onNameChange: _onNameChange,
        onWorkDurationChange: _onWorkDurationChange,
        onRestDurationChange: _onRestDurationChange,
        onWorkSetsChange: _onWorkSetsChange,
      ),
    );
  }
}

class CreateEditWorkoutForm extends StatelessWidget {
  CreateEditWorkoutForm(
    this.name,
    this.workDuration,
    this.restDuration,
    this.workSets, {
    Key key,
    this.onNameChange,
    this.onWorkDurationChange,
    this.onRestDurationChange,
    this.onWorkSetsChange,
  });

  final String name;
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;
  final Function onNameChange;
  final Function onWorkDurationChange;
  final Function onRestDurationChange;
  final Function onWorkSetsChange;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListItem(
            title: 'Workout Name',
            subTitle: name,
            subTitleColour: Colors.grey,
            onTap: () async {
              final newName = await Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditTextPage(
                            title: 'Workout Name',
                            initValue: name,
                            hintText: 'Enter A Workout Name',
                          ),
                    ),
                  );

              if (onNameChange != null) {
                onNameChange(newName);
              }
            },
          ),
          new ListItem(
            title: 'Work Duration',
            subTitle: workDuration.toString(),
            subTitleColour: Colors.green,
            onTap: () async {
              var newDuration = await Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditTimePage(
                            title: 'Work Duration',
                            duration: workDuration,
                            colour: Colors.green,
                          ),
                    ),
                  );

              if (onWorkDurationChange != null) {
                onWorkDurationChange(newDuration);
              }
            },
          ),
          new ListItem(
            title: 'Rest Duration',
            subTitle: restDuration.toString(),
            subTitleColour: Colors.blue,
            onTap: () async {
              var newDuration = await Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditTimePage(
                            title: 'Rest Duration',
                            duration: restDuration,
                            colour: Colors.blue,
                          ),
                    ),
                  );

              if (onRestDurationChange != null) {
                onRestDurationChange(newDuration);
              }
            },
          ),
          new ListItem(
            title: 'Sets',
            subTitle: workSets.length == 0 ? 'None Added' : '',
            subTitleColour: Colors.grey,
            onTap: () async {
              var newWorkSets = await Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new CreateEditWorkSetsPage(
                            workSets: workSets,
                          ),
                    ),
                  );

              if (onWorkSetsChange != null) {
                onWorkSetsChange(newWorkSets);
              }
            },
          ),
          new Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: workSets
                  .map(
                    (WorkSet ws) => new Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: new Text(
                            ws.name,
                            style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    Key key,
    @required this.title,
    @required this.subTitle,
    this.subTitleColour: Colors.white,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final Color subTitleColour;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: new ListTile(
        title: new Text(
          title,
          style: new TextStyle(
            fontSize: 25.0,
          ),
        ),
        subtitle: new Text(
          subTitle,
          style: new TextStyle(
            fontSize: 20.0,
            color: subTitleColour,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: new Icon(
          Icons.arrow_right,
          size: 50.0,
        ),
        onTap: onTap,
      ),
    );
  }
}
