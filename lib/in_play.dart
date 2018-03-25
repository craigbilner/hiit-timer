import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'timer.dart';
import 'helpers.dart';

class InPlayPage extends StatelessWidget {
  InPlayPage({
    Key key,
    this.title,
  })
      : super(key: key);

  final String title;
  final double fontSize = 75.0;
  final FontWeight fontWeight = FontWeight.w100;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(title),
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
            initValue: 10,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new RestItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new RepsItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          new SetsItem(
            fontSize: fontSize,
            fontWeight: fontWeight,
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
                    fontSize: 20.0,
                  ),
                ),
                new Text(
                  subTitle,
                  style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
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
    this.initValue: 0,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final int initValue;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      title: 'Work',
      subTitle: 'Swing',
      mainItem: new CustomTimer(
        initValue: initValue,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class RestItem extends StatelessWidget {
  RestItem({
    Key key,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        formatTime(7),
        style: new TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      title: 'Rest',
    );
  }
}

class RepsItem extends StatelessWidget {
  RepsItem({
    Key key,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '0 / 1',
        style: new TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      title: 'Reps',
      subTitle: 'Interval',
    );
  }
}

class SetsItem extends StatelessWidget {
  SetsItem({
    Key key,
    this.fontSize: 20.0,
    this.fontWeight: FontWeight.normal,
  });

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      mainItem: new Text(
        '1 / 200',
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
