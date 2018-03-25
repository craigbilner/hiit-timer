String toTwoDigits(int num) {
  if (num < 10) {
    return '0$num';
  }

  return num.toString();
}

String formatTime(Duration duration) {
  final int _mins = duration.inSeconds ~/ 60;
  final int _secs = duration.inSeconds - (_mins * 60);
  final String mins = toTwoDigits(_mins);
  final String secs = toTwoDigits(_secs);

  return '$mins:$secs';
}
