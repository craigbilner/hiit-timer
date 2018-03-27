import 'package:flutter/material.dart';
import 'helpers.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new TimeWheel(
            title: 'Work Duration',
            seconds: 30,
            colour: Colors.green,
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
            ),
            child: new TimeWheel(
              title: 'Rest Duration',
              seconds: 15,
              colour: Colors.blue,
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

class TimeWheel extends StatelessWidget {
  TimeWheel({
    Key key,
    this.title,
    this.minutes: 0,
    this.seconds: 0,
    this.colour,
  });

  final String title;
  final int minutes;
  final int seconds;
  final Color colour;
  final TextStyle wheelLabel = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(
            left: 24.0,
          ),
          child: new Text(
            title,
            style: new TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(24.0),
          child: new Row(
            children: <Widget>[
              new Text(
                'Minutes',
                style: wheelLabel,
              ),
              new Container(
                margin: const EdgeInsets.only(
                  left: 40.0,
                ),
                child: new Text(
                  'Seconds',
                  style: wheelLabel,
                ),
              ),
            ],
          ),
        ),
        new Row(
          children: [
            new TimeUnitWheel(initialItem: minutes, colour: colour),
            new Text(
              ':',
              style: new TextStyle(
                color: colour,
                fontSize: 50.0,
              ),
            ),
            new TimeUnitWheel(initialItem: seconds, colour: colour),
          ],
        ),
      ],
    );
  }
}

class TimeUnitWheel extends StatelessWidget {
  TimeUnitWheel({
    Key key,
    this.initialItem: 0,
    this.colour,
  })
      : _controller = new FixedExtentScrollController(
          initialItem: initialItem,
        );

  final int initialItem;
  final Color colour;
  final FixedExtentScrollController _controller;
  final List<int> timeUnits = new List.generate(
    60,
    (int indx) {
      return indx;
    },
  );
  final double wheelWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 125.0,
      width: wheelWidth,
      child: new ListWheelScrollView(
        controller: _controller,
        itemExtent: 50.0,
        children: timeUnits
            .map(
              (int second) => new Text(
                    toTwoDigits(second),
                    style: new TextStyle(
                      fontSize: 50.0,
                      color: colour,
                    ),
                  ),
            )
            .toList(),
      ),
    );
  }
}
