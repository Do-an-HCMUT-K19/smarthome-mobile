import 'package:flutter/cupertino.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/utils/firebase_utils.dart';

class TimerState with ChangeNotifier {
  final Map<RoomType, List<Timer>> _timerList = {
    RoomType.livingRoom: [],
    RoomType.bathRoom: [],
    RoomType.bedRoom: [],
    RoomType.kitChen: [],
    RoomType.garden: [],
  };

  final Map<RoomType, List<String>> _bulbList = {
    RoomType.livingRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.bathRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.bedRoom: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.kitChen: ['Bulb #1', 'Bulb #2', 'Bulb #3', 'Bulb #4'],
    RoomType.garden: ['Bulb #1', 'Bulb #2'],
  };

  Future<void> initValue() async {
    _timerList[RoomType.livingRoom] = [];
    _timerList[RoomType.bedRoom] = [];
    _timerList[RoomType.bathRoom] = [];
    _timerList[RoomType.kitChen] = [];
    _timerList[RoomType.garden] = [];

    ReturnMessage returnMsg = await FirebaseUtils.getAllTimers({
      'AccountName': 'giacat',
    });
    List<Timer> timerList = returnMsg.data;
    timerList.sort((a, b) => a.sensor_id.compareTo(b.sensor_id));
    timerList.forEach((element) {
      if (element.sensor_id <= 4) {
        _timerList[RoomType.livingRoom]!.add(element);
      } else if (element.sensor_id <= 8) {
        _timerList[RoomType.bedRoom]!.add(element);
      } else if (element.sensor_id <= 12) {
        _timerList[RoomType.bathRoom]!.add(element);
      } else if (element.sensor_id <= 16) {
        _timerList[RoomType.kitChen]!.add(element);
      } else {
        _timerList[RoomType.garden]!.add(element);
      }
    });
    notifyListeners();
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
    required String timeOfDay,
  }) {
    Timer timer = Timer(
      name: name,
      dayOfWeek: dayOfWeek,
      duration: Duration(hours: duration),
      isAutoOff: isAutoOff,
      sensor_id: _getSensorId(roomType, name),
      timeOfDay: timeOfDay,
    );
    _timerList[roomType]!.add(timer);
    FirebaseUtils.setTimer({
      'AccountName': 'giacat',
      'Duration': duration,
      'State': isAutoOff ? 'off' : 'on',
      'SensorId': _getSensorId(roomType, name),
      'DateOfWeek': dayOfWeek,
      'TimerId': timer.id,
      'Name': name,
      'TimeOfDay': timeOfDay,
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
      RoomType.bedRoom,
      RoomType.bathRoom,
      RoomType.kitChen,
      RoomType.garden
    ];
    return roomList.indexOf(roomType) * 4 + idx;
  }
}
