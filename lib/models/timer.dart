import 'package:uuid/uuid.dart';

class Timer {
  late String id;
  String name;
  String dayOfWeek;
  Duration duration;
  bool isAutoOff = true;
  String accountName = 'giacat';
  String timeOfDay;
  late int sensor_id;

  Timer({
    required this.timeOfDay,
    required this.name,
    required this.dayOfWeek,
    required this.duration,
    required this.isAutoOff,
    id,
    sensor_id,
  }) {
    if (id == null) {
      this.id = const Uuid().v1();
    } else {
      this.id = id;
    }
    this.sensor_id = sensor_id;
  }
}
