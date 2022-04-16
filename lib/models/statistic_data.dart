import 'package:cloud_firestore/cloud_firestore.dart';

class EnvData {
  int hour;
  double temp;
  double landHumid;
  double airHumid;

  EnvData({
    required this.hour,
    required this.temp,
    required this.landHumid,
    required this.airHumid,
  });
}
