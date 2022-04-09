import 'package:uuid/uuid.dart';

class Timer {
  late String id;
  String name;
  String dayOfWeek;
  Duration duration;
  bool isAutoOff = true;
  String accountName = 'giacat';
  late int sensor_id;

  Timer(
      {required this.name,
      required this.dayOfWeek,
      required this.duration,
      required this.isAutoOff,
      id}) {
    if (id == null) {
      this.id = const Uuid().v1();
    } else {
      this.id = id;
    }
  }
}
