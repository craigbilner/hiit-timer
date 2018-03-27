import 'package:flutter/material.dart';

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
  final TextEditingController _controller = new TextEditingController();
  final List<int> seconds = new List.generate(59, (int indx) {
    return indx;
  });
  final double wheelWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new Text(
            'Work Duration',
            style: new TextStyle(
              fontSize: 20.0,
            ),
          ),
          new Row(
            children: [
              new Container(
                height: 125.0,
                width: wheelWidth,
                child: new ListWheelScrollView(
                  itemExtent: 50.0,
                  children: seconds
                      .map(
                        (int second) => new Text(
                              second.toString(),
                              style: new TextStyle(
                                fontSize: 50.0,
                              ),
                            ),
                      )
                      .toList(),
                ),
              ),
              new Text(
                ':',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
              new Container(
                height: 125.0,
                width: wheelWidth,
                child: new ListWheelScrollView(
                  itemExtent: 50.0,
                  children: seconds
                      .map(
                        (int second) => new Text(
                              second.toString(),
                              style: new TextStyle(
                                fontSize: 50.0,
                              ),
                            ),
                      )
                      .toList(),
                ),
              ),
            ],
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
