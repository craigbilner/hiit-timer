String toTwoDigits(int num) {
  if (num < 10) {
    return '0$num';
  }

  return num.toString();
}

String formatTime(int curTimeInSecs) {
  final int _mins = curTimeInSecs ~/ 60;
  final int _secs = curTimeInSecs - (_mins * 60);
  final String mins = toTwoDigits(_mins);
  final String secs = toTwoDigits(_secs);

  return '$mins:$secs';
}
