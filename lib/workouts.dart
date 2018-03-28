import 'package:flutter/material.dart';
import 'models.dart';
import 'in_play.dart';

class WorkoutsPage extends StatelessWidget {
  WorkoutsPage(this.workouts, {Key key}) : super(key: key);

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text('Workouts'),
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
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/create_workout'),
        child: new Icon(
          Icons.add,
        ),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        children: workouts
            .map((Workout w) => new ListTile(
                  title: new Text(
                    w.name,
                    style: new TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  trailing: new Icon(
                    Icons.arrow_right,
                    size: 50.0,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext bc) => new InPlayPage(
                                  title: w.name,
                                  workDuration: w.workDuration,
                                  restDuration: w.restDuration,
                                  workSets: w.workSets,
                                ),
                          ),
                        );
                  },
                ))
            .toList(),
      ),
    );
  }
}
