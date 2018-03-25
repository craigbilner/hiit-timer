import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool fser = false;
  bool ver = false;
  bool pna = false;
  bool frs = false;
  double nps = 0.0;
  double wb = 3.0;
  bool wwb = false;

  final TextStyle labelStyle = new TextStyle(
    fontSize: 20.0,
  );
  final double sliderCountSize = 25.0;
  final double arrowSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text('Settings'),
        ),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        children: <Widget>[
          new ListTile(
            title: new Text(
              'Flash Screen Each Rep',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: fser,
              onChanged: (bool newValue) {
                setState(() {
                  fser = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Vibrate Each Rep',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: ver,
              onChanged: (bool newValue) {
                setState(() {
                  ver = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Preview Next Activity',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: pna,
              onChanged: (bool newValue) {
                setState(() {
                  pna = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Final Rep Sync',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: frs,
              onChanged: (bool newValue) {
                setState(() {
                  frs = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Prep Seconds',
              style: labelStyle,
            ),
            subtitle: new Text(
              nps.toInt().toString(),
              style: new TextStyle(
                fontSize: sliderCountSize,
              ),
            ),
            trailing: new Slider(
              value: nps,
              min: 0.0,
              max: 10.0,
              onChanged: (double newValue) {
                setState(() {
                  nps = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Warning Beeps',
              style: labelStyle,
            ),
            subtitle: new Text(
              wb.toInt().toString(),
              style: new TextStyle(
                fontSize: sliderCountSize,
              ),
            ),
            trailing: new Slider(
              value: wb,
              min: 0.0,
              max: 10.0,
              onChanged: (double newValue) {
                setState(() {
                  wb = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Work Warning Beeps',
              style: labelStyle,
            ),
            trailing: new Switch(
              value: wwb,
              onChanged: (bool newValue) {
                setState(() {
                  wwb = newValue;
                });
              },
            ),
          ),
          new ListTile(
            title: new Text(
              'Sound Chooser',
              style: labelStyle,
            ),
            trailing: new Icon(
              Icons.arrow_right,
              size: arrowSize,
            ),
          ),
          new ListTile(
            title: new Text(
              'Spoken Alerts',
              style: labelStyle,
            ),
            trailing: new Icon(
              Icons.arrow_right,
              size: arrowSize,
            ),
          ),
        ],
      ),
    );
  }
}
