import 'package:flutter/cupertino.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/utils/firebase_utils.dart';

class TimerState with ChangeNotifier {
  final Map<RoomType, List<Timer>> _timerList = {
    RoomType.livingRoom: [
      Timer(
        name: 'Bulb #3',
        dayOfWeek: 'Sat',
        duration: Duration(days: 1),
        isAutoOff: true,
      )
    ],
    RoomType.bathRoom: [
      Timer(
        name: 'Bulb #1',
        dayOfWeek: 'Sat',
        duration: Duration(days: 1),
        isAutoOff: true,
      )
    ],
    RoomType.bedRoom: [
      Timer(
        name: 'Bulb #1',
        dayOfWeek: 'Sat',
        duration: Duration(days: 1),
        isAutoOff: true,
      )
    ],
    RoomType.kitChen: [
      Timer(
        name: 'Bulb #2',
        dayOfWeek: 'Sat',
        duration: Duration(days: 1),
        isAutoOff: true,
      )
    ],
    RoomType.garden: [
      Timer(
        name: 'Bulb #4',
        dayOfWeek: 'Sat',
        duration: Duration(days: 1),
        isAutoOff: true,
      )
    ],
  };

  final Map<RoomType, List<String>> _bulbList = {
    RoomType.livingRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.bathRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.bedRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.kitChen: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.garden: ['Bulb #1', 'Bulb #2'],
  };

  Future<void> initValue() async {
    List<Timer> resultList = await FirebaseUtils.getAllTimers({
      'AccountName': 'giacat',
    });
    resultList.sort((a, b) => a.sensor_id.compareTo(b.sensor_id));
  }

  List<String> getBulbList(RoomType roomType) {
    return _bulbList[roomType]!;
  }

  List<Timer> getTimerList(RoomType roomType) {
    return _timerList[roomType]!;
  }

  void addTimer({
    required String dayOfWeek,
    required int duration,
    required bool isAutoOff,
    required String name,
    required RoomType roomType,
  }) {
    Timer timer = Timer(
      name: name,
      dayOfWeek: dayOfWeek,
      duration: Duration(hours: duration),
      isAutoOff: isAutoOff,
    );
    timer.sensor_id = _getSensorId(roomType, name);
    _timerList[roomType]!.add(timer);
    FirebaseUtils.setTimer({
      'AccountName': 'giacat',
      'Duration': duration,
      'State': isAutoOff ? 'off' : 'on',
      'SensorId': _getSensorId(roomType, name),
      'DateOfWeek': dayOfWeek,
      'TimerId': timer.id,
      'Name': name
    });
    notifyListeners();
  }

  void removeTimer({
    required String id,
    required RoomType roomType,
  }) {
    _timerList[roomType]!.removeWhere((element) => element.id == id);
    FirebaseUtils.deleteTimer({
      'ID': id,
    });
    notifyListeners();
  }

  int _getSensorId(RoomType roomType, String name) {
    int idx = int.parse(name.split('#')[1]);
    List<RoomType> roomList = [
      RoomType.livingRoom,
      RoomType.bathRoom,
      RoomType.bedRoom,
      RoomType.kitChen,
      RoomType.garden
    ];
    return roomList.indexOf(roomType) * 4 + idx;
  }
}
