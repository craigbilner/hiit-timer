import 'dart:convert';

class Workouts {
  Workouts(this.workouts);

  final List<Workout> workouts;

  Map<String, dynamic> toJson() => {
        'workouts': workouts.map((Workout w) => json.encode(w)).toList(),
      };

  Workouts.fromJson(Map<String, dynamic> m)
      : workouts = m['workouts']
            .map(
              (e) => new Workout.fromJson(
                    json.decode(e),
                  ),
            )
            .toList();
}

class Workout {
  Workout(
    this.name,
    this.workDuration,
    this.restDuration,
    this.workSets,
  );

  int id = new DateTime.now().millisecondsSinceEpoch;
  final String name;
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'workDuration': json.encode(workDuration),
        'restDuration': json.encode(restDuration),
        'workSets': workSets.map((WorkSet ws) => json.encode(ws)).toList(),
      };

  Workout.fromJson(Map<String, dynamic> m)
      : id = int.parse(m['id']),
        name = m['name'],
        workDuration = new TimeDuration.fromJson(
          json.decode(
            m['workDuration'],
          ),
        ),
        restDuration = new TimeDuration.fromJson(
          json.decode(
            m['restDuration'],
          ),
        ),
        workSets = m['workSets']
            .map(
              (e) => new WorkSet.fromJson(
                    json.decode(e),
                  ),
            )
            .toList();
}

class WorkSet {
  WorkSet(
    this.name, {
    this.isComplete: false,
  });

  final String name;
  bool isComplete;

  Map<String, dynamic> toJson() => {
        'name': name,
        'isComplete': isComplete,
      };

  WorkSet.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isComplete = json['isComplete'];
}

class TimeDuration {
  TimeDuration(this.duration);

  Duration duration;

  int get minutes {
    return duration.inSeconds ~/ 60;
  }

  int get seconds {
    return duration.inSeconds - (minutes * 60);
  }

  int get inSeconds {
    return duration.inSeconds;
  }

  set minutes(int minute) {
    duration = new Duration(minutes: minute, seconds: seconds);
  }

  set seconds(int second) {
    duration = new Duration(minutes: minutes, seconds: second);
  }

  static String toTwoDigits(int num) {
    if (num < 10) {
      return '0$num';
    }

    return num.toString();
  }

  String toString() {
    final String mins = toTwoDigits(minutes);
    final String secs = toTwoDigits(seconds);

    return '$mins:$secs';
  }

  TimeDuration clone() {
    return new TimeDuration(
      new Duration(
        minutes: minutes,
        seconds: seconds,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'minutes': minutes.toString(),
        'seconds': seconds.toString(),
      };

  TimeDuration.fromJson(Map<String, dynamic> json)
      : duration = new Duration(
          minutes: int.parse(json['minutes']),
          seconds: int.parse(json['seconds']),
        );
}
