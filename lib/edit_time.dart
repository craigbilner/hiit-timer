import 'package:flutter/material.dart';
import 'models.dart';

typedef OnSelectedItemChanged(int indx);
typedef OnChange(TimeDuration duration);

class EditTimePage extends StatefulWidget {
  EditTimePage({
    Key key,
    this.title,
    this.duration,
    this.colour,
  });

  final String title;
  final TimeDuration duration;
  final Color colour;

  @override
  _EditTimePageState createState() => new _EditTimePageState();
}

class _EditTimePageState extends State<EditTimePage> {
  TimeDuration duration;

  @override
  initState() {
    super.initState();

    duration = widget.duration;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit Time'),
        actions: <Widget>[
          new MaterialButton(
            child: new Text(
              'Save',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(duration),
          ),
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new TimeWheel(
          title: widget.title,
          duration: duration,
          colour: widget.colour,
          onChange: (TimeDuration newDuration) {
            duration = newDuration;
          },
        ),
      ),
    );
  }
}

class TimeWheel extends StatefulWidget {
  TimeWheel({
    Key key,
    this.title,
    this.duration,
    this.colour,
    this.onChange,
  });

  final String title;
  final TimeDuration duration;
  final Color colour;
  final OnChange onChange;

  @override
  _TimeWheelState createState() => new _TimeWheelState();
}

class _TimeWheelState extends State<TimeWheel> {
  TimeDuration duration;
  final TextStyle wheelLabel = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  void _onMinuteChange(int minute) {
    duration.minutes = minute;

    if (widget.onChange != null) {
      widget.onChange(duration);
    }
  }

  void _onSecondChange(int second) {
    duration.seconds = second;

    if (widget.onChange != null) {
      widget.onChange(duration);
    }
  }

  @override
  initState() {
    super.initState();

    duration = widget.duration.clone();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Text(
            widget.title,
            style: new TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new TimeUnitWheel(
              initialItem: duration.minutes,
              colour: widget.colour,
              onSelectedItemChanged: _onMinuteChange,
            ),
            new Text(
              ':',
              style: new TextStyle(
                color: widget.colour,
                fontSize: 50.0,
              ),
            ),
            new TimeUnitWheel(
              initialItem: duration.seconds,
              colour: widget.colour,
              onSelectedItemChanged: _onSecondChange,
            ),
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
    this.onSelectedItemChanged,
  })
      : _controller = new FixedExtentScrollController(
          initialItem: initialItem,
        );

  final int initialItem;
  final Color colour;
  final OnSelectedItemChanged onSelectedItemChanged;
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
                    TimeDuration.toTwoDigits(second),
                    style: new TextStyle(
                      fontSize: 50.0,
                      color: colour,
                    ),
                  ),
            )
            .toList(),
        onSelectedItemChanged: onSelectedItemChanged,
      ),
    );
  }
}
