import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'edit_time.dart';
import 'edit_text.dart';
import 'models.dart';

class CreateWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(
            'Create Workout',
            style: new TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        actions: <Widget>[
          new MaterialButton(
            child: new Text(
              'Create',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            onPressed: null,
          ),
        ],
      ),
      body: new CreateWorkoutForm(),
    );
  }
}

class CreateWorkoutForm extends StatefulWidget {
  @override
  _CreateWorkoutFormState createState() => new _CreateWorkoutFormState();
}

class _CreateWorkoutFormState extends State<CreateWorkoutForm> {
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
          ),
          new Column(
            children: workSets
                .map(
                  (WorkSet ws) => new Text(
                        ws.name,
                        style: new TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                )
                .toList(),
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
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: new ListTile(
        title: new Text(
          title,
          style: new TextStyle(
            fontSize: 30.0,
          ),
        ),
        subtitle: new Text(
          subTitle,
          style: new TextStyle(
            fontSize: 25.0,
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
