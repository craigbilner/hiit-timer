class WorkSet {
  WorkSet(
    this.name, {
    this.isComplete: false,
  });

  final String name;
  bool isComplete;
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
}
