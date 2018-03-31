import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'timer.dart';
import 'models.dart';

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
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;
  final double fontSize = 75.0;
  final FontWeight fontWeight = FontWeight.w100;

  @override
  _InPlayPageState createState() => new _InPlayPageState();
}

class _InPlayPageState extends State<InPlayPage> {
  List<WorkSet> currentSets;
  bool workIsFrozen = false;
  bool restIsFrozen = true;

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
        workIsFrozen = true;
        restIsFrozen = false;
      }
    });
  }

  void _onRestComplete() {
    setState(() {
      if (currentSet != null) {
        workIsFrozen = false;
        restIsFrozen = true;
      }
    });
  }

  @override
  initState() {
    super.initState();

    currentSets = widget.workSets.map((w) => w.clone()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(widget.title),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new TimerItem(
            'Work',
            subTitle: currentSet == null ? null : currentSet.name,
            initValue: widget.workDuration,
            isFrozen: workIsFrozen,
            onComplete: _onWorkComplete,
            colour: Colors.green,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
          new TimerItem(
            'Rest',
            initValue: widget.restDuration,
            isFrozen: restIsFrozen,
            onComplete: _onRestComplete,
            colour: Colors.blue,
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
    this.subTitle,
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
                  subTitle == null ? '' : subTitle,
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
  TimerItem(
    this.title, {
    Key key,
    this.subTitle: '',
    this.initValue,
    this.isFrozen: true,
    this.onComplete,
    this.colour: Colors.black,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final String title;
  final String subTitle;
  final TimeDuration initValue;
  final bool isFrozen;
  final Function onComplete;
  final Color colour;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: title,
      subTitle: subTitle,
      mainItem: new CustomTimer(
        initValue: initValue,
        isFrozen: isFrozen,
        onComplete: onComplete,
        colour: colour,
        fontSize: fontSize,
        fontWeight: fontWeight,
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
