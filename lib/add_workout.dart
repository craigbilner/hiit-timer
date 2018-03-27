import 'package:flutter/material.dart';
import 'edit_time.dart';
import 'models.dart';

class AddWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(
            'Add Workout',
          ),
        ),
      ),
      body: new AddWorkoutForm(),
    );
  }
}

class AddWorkoutForm extends StatefulWidget {
  @override
  _AddWorkoutFormState createState() => new _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  // final TextEditingController _controller = new TextEditingController();
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

  final double titleSize = 30.0;
  final double subTitleSize = 25.0;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            title: new Text(
              'Work Duration',
              style: new TextStyle(
                fontSize: titleSize,
              ),
            ),
            subtitle: new Text(
              workDuration.toString(),
              style: new TextStyle(
                fontSize: subTitleSize,
                color: Colors.green,
              ),
            ),
            trailing: new Icon(
              Icons.arrow_right,
              size: 50.0,
            ),
            onTap: () {
              Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new EditTimePage(
                            title: 'Work Duration',
                            duration: workDuration,
                            colour: Colors.green,
                          ),
                    ),
                  );
            },
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
            ),
            child: new ListTile(
              title: new Text(
                'Rest Duration',
                style: new TextStyle(
                  fontSize: titleSize,
                ),
              ),
              subtitle: new Text(
                restDuration.toString(),
                style: new TextStyle(
                  fontSize: subTitleSize,
                  color: Colors.blue,
                ),
              ),
              trailing: new Icon(
                Icons.arrow_right,
                size: 50.0,
              ),
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

                workDuration = newDuration;
              },
            ),
          ),
          new Container(
            alignment: Alignment.centerRight,
            child: new RaisedButton(
              onPressed: () {},
              child: new Text(
                'Add',
                style: new TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
