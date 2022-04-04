class Timer {
  int idx;
  DateTime dateTime;
  Duration duration;
  bool isAutoOff = true;

  Timer({
    required this.idx,
    required this.dateTime,
    required this.duration,
    required this.isAutoOff,
  });
}
