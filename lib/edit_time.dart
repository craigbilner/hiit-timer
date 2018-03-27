import 'package:flutter/material.dart';
import 'models.dart';

typedef OnSelectedItemChanged(int indx);
typedef OnChange(TimeDuration duration);

class EditTimePage extends StatelessWidget {
  EditTimePage({
    Key key,
    this.title,
    this.duration,
    this.colour,
  });

  final String title;
  TimeDuration duration;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit Time'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new TimeWheel(
          title: title,
          duration: duration,
          colour: colour,
          onChange: (TimeDuration duration) {
            duration = duration;
          },
        ),
      ),
    );
  }
}

class TimeWheel extends StatelessWidget {
  TimeWheel({
    Key key,
    this.title,
    this.duration,
    this.colour,
    this.onChange,
  });

  final String title;
  TimeDuration duration;
  final Color colour;
  final OnChange onChange;
  final TextStyle wheelLabel = new TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  void _onMinuteChange(int minute) {
    duration.minutes = minute;

    if (onChange != null) {
      onChange(duration);
    }
  }

  void _onSecondChange(int second) {
    duration.seconds = second;

    if (onChange != null) {
      onChange(duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Text(
            title,
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
              colour: colour,
              onSelectedItemChanged: _onMinuteChange,
            ),
            new Text(
              ':',
              style: new TextStyle(
                color: colour,
                fontSize: 50.0,
              ),
            ),
            new TimeUnitWheel(
              initialItem: duration.seconds,
              colour: colour,
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
