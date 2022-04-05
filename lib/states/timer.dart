import 'package:flutter/cupertino.dart';
import 'package:smart_home/models/timer.dart';

class TimerState with ChangeNotifier {
  final List<Timer> _timerList = [
    Timer(
        name: 'Bulb no.1',
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
    Timer(
        name: 'Bulb no.2',
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
    Timer(
        name: 'Bulb no.1',
        dateTime: DateTime.now(),
        duration: Duration(days: 1),
        isAutoOff: true),
  ];

  List<String> _bulbList = [
    'Bulb no.1',
    'Bulb no.2',
    'Bulb no.3',
    'Bulb no.4',
  ];

  List<String> get bulbList => _bulbList;

  List<Timer> get timerList => _timerList;

  void addTimer(
      {required DateTime dateTime,
      required int duration,
      required bool isAutoOff,
      required String name}) {
    Timer timer = Timer(
      name: name,
      dateTime: dateTime,
      duration: Duration(hours: duration),
      isAutoOff: isAutoOff,
    );
    _timerList.add(timer);
    notifyListeners();
  }

  void removeTimer(String id) {
    _timerList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
