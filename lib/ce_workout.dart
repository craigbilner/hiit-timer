import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'edit_time.dart';
import 'edit_text.dart';
import 'ce_sets.dart';
import 'models.dart';

class CreateEditWorkoutPage extends StatelessWidget {
  CreateEditWorkoutPage({
    Key key,
    this.actionName,
  });

  final String actionName;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return new File('$path/workouts.txt');
  }

  Future<File> writeWorkout(Workout w) async {
    final file = await _localFile;

    print(w.toString());

    return file.writeAsString(w.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new MaterialButton(
            child: new Text(
              actionName,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: null,
          ),
        ],
      ),
      body: new CreateEditWorkoutForm(),
    );
  }
}

class CreateEditWorkoutForm extends StatefulWidget {
  @override
  _CreateEditWorkoutFormState createState() =>
      new _CreateEditWorkoutFormState();
}

class _CreateEditWorkoutFormState extends State<CreateEditWorkoutForm> {
  TimeDuration workDuration = new TimeDuration(
    new Duration(
      seconds: 30,
    ),
  );
  TimeDuration restDuration = new TimeDuration(
    new Duration(
      seconds: 15,
    ),
  );
  String workoutName = 'New Workout';
  List<WorkSet> workSets = [];

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListItem(
            title: 'Workout Name',
            subTitle: workoutName,
            subTitleColour: Colors.grey,
            onTap: () async {
              var newName = await Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditTextPage(
                            title: 'Workout Name',
                            initValue: workoutName,
                            hintText: 'Enter A Workout Name',
                          ),
                    ),
                  );

              if (newName != null) {
                workoutName = newName;
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

              if (newDuration != null) {
                workDuration = newDuration;
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

              if (newDuration != null) {
                restDuration = newDuration;
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

              if (newWorkSets != null) {
                workSets = newWorkSets;
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
