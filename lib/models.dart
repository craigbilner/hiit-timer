import 'dart:convert';

class Workout {
  Workout(
    this.name,
    this.workDuration,
    this.restDuration,
    this.workSets,
  );

  final String name;
  final TimeDuration workDuration;
  final TimeDuration restDuration;
  final List<WorkSet> workSets;

  Map<String, dynamic> toJson() => {
        'name': name,
        'workDuration': json.encode(workDuration),
        'restDuration': json.encode(restDuration),
        'workSets': workSets.map((WorkSet ws) => json.encode(ws)).toList(),
      };
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
}
