import 'package:flutter/cupertino.dart';
import 'package:smart_home/models/timer.dart';

class TimerState with ChangeNotifier {
  final List<Timer> _timerList = [
    Timer(
        idx: 0,
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
    Timer(
        idx: 1,
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
    Timer(
        idx: 2,
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
  ];

  List<Timer> get timerList => _timerList;

  void addTimer(
      {required DateTime dateTime,
      required int duration,
      required bool isAutoOff}) {
    Timer timer = Timer(
      idx: _timerList.length,
      dateTime: dateTime,
      duration: Duration(hours: duration),
      isAutoOff: isAutoOff,
    );
    _timerList.add(timer);
    notifyListeners();
  }

  void removeTimer(int idx) {
    _timerList.removeWhere((element) => element.idx == idx);
    notifyListeners();
  }
}
