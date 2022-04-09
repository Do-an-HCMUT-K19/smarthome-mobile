import 'package:cloud_firestore/cloud_firestore.dart';

class EnvData {
  int hour;
  double temp;
  double humid;

  EnvData({
    required this.hour,
    required this.temp,
    required this.humid,
  });
}
