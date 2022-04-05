import 'package:uuid/uuid.dart';

class Timer {
  final String id = Uuid().v1();
  String name;
  DateTime dateTime;
  Duration duration;
  bool isAutoOff = true;

  Timer({
    required this.name,
    required this.dateTime,
    required this.duration,
    required this.isAutoOff,
  });
}
