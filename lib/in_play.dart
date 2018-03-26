import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'timer.dart';
import 'helpers.dart';

class WorkSet {
  WorkSet(
    this.name, {
    this.isComplete: false,
  });

  final String name;
  bool isComplete;
}

class InPlayPage extends StatefulWidget {
  InPlayPage({
    Key key,
    @required this.title,
    @required this.workDuration,
    @required this.restDuration,
    this.workSets,
  })
      : super(key: key);

  final String title;
  final Duration workDuration;
  final Duration restDuration;
  final List<WorkSet> workSets;
  final double fontSize = 75.0;
  final FontWeight fontWeight = FontWeight.w100;

  @override
  _InPlayPageState createState() => new _InPlayPageState();
}

class _InPlayPageState extends State<InPlayPage> {
  List<WorkSet> currentSets;

  int get setsCompleted {
    if (currentSets == null) {
      return 0;
    }

    return currentSets.where((WorkSet ws) {
      return ws.isComplete;
    }).length;
  }

  WorkSet get currentSet {
    if (currentSets == null) {
      return null;
    }

    return currentSets.firstWhere(
      (WorkSet ws) {
        return !ws.isComplete;
      },
      orElse: () {
        return null;
      },
    );
  }

  void _onWorkComplete() {
    setState(() {
      if (currentSet != null) {
        currentSet.isComplete = true;
      }
    });
  }

  @override
  initState() {
    super.initState();

    currentSets = new List.from(widget.workSets);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(widget.title),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new TimerItem(
            workSet: currentSet,
            initValue: widget.workDuration,
            onComplete: _onWorkComplete,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
          new RestItem(
            duration: widget.restDuration,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
          new SetsItem(
            setsCompleted: setsCompleted,
            totalSets: widget.workSets.length,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    Key key,
    @required this.mainItem,
    @required this.title,
    this.subTitle: '',
  })
      : super(key: key);

  final Widget mainItem;
  final String title;
  final String subTitle;
  final double labelSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 150.0,
            padding: const EdgeInsets.all(32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  title,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: labelSize,
                  ),
                ),
                new Text(
                  subTitle,
                  style: new TextStyle(
                    color: Colors.grey,
                    fontSize: labelSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
            child: mainItem,
          )
        ],
      ),
    );
  }
}

class TimerItem extends StatelessWidget {
  TimerItem({
    Key key,
    this.workSet,
    this.initValue,
    this.onComplete,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final WorkSet workSet;
  final Duration initValue;
  final Function onComplete;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: 'Work',
      subTitle: workSet == null ? '' : workSet.name,
      mainItem: new CustomTimer(
        initValue: initValue,
        onComplete: onComplete,
        colour: Colors.green,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class RestItem extends StatelessWidget {
  RestItem({
    Key key,
    @required this.duration,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final Duration duration;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: 'Rest',
      mainItem: new Text(
        formatTime(duration),
        style: new TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class SetsItem extends StatelessWidget {
  SetsItem({
    Key key,
    this.setsCompleted: 0,
    this.totalSets,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final int setsCompleted;
  final int totalSets;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    var text = totalSets != 0
        ? '$setsCompleted / $totalSets'
        : setsCompleted.toString();

    return new ListItem(
      mainItem: new Text(
        text,
        style: new TextStyle(
          color: Colors.orange,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      title: 'Sets',
    );
  }
}
