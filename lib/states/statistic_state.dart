import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/models/return_msg.dart';

class StatisticState with ChangeNotifier {
  List<FlSpot> _tempData = [];
  List<FlSpot> _humidData = [];

  double _maxXHumid = 10;
  double _maxXTemp = 10;

  List<FlSpot> get tempData => _tempData;
  List<FlSpot> get humidData => _humidData;

  double get maxXHumid => _maxXHumid;
  double get maxXTemp => _maxXTemp;

  Future<void> renewData(RoomType roomType, DateTime time) async {
    _tempData = [];
    _humidData = [];
    ReturnMessage returnMessage;
    if (roomType == RoomType.livingRoom) {
      returnMessage = await FirebaseUtils.getStatisticData({
        'AccountName': 'giacat',
        'Area': 'living_room',
        'Timestamp': Timestamp.fromDate(time)
      });
    } else if (roomType == RoomType.bathRoom) {
      returnMessage = await FirebaseUtils.getStatisticData({
        'AccountName': 'giacat',
        'Area': 'bath_room',
        'Timestamp': Timestamp.fromDate(time)
      });
    } else if (roomType == RoomType.bedRoom) {
      returnMessage = await FirebaseUtils.getStatisticData({
        'AccountName': 'giacat',
        'Area': 'bed_room',
        'Timestamp': Timestamp.fromDate(time)
      });
    } else if (roomType == RoomType.kitChen) {
      returnMessage = await FirebaseUtils.getStatisticData({
        'AccountName': 'giacat',
        'Area': 'kitchen',
        'Timestamp': Timestamp.fromDate(time)
      });
    } else {
      returnMessage = await FirebaseUtils.getStatisticData({
        'AccountName': 'giacat',
        'Area': 'garden',
        'Timestamp': Timestamp.fromDate(time)
      });
    }
    for (var i in returnMessage.message) {
      _tempData.add(FlSpot(i.hour.toDouble(), i.temp));
      _humidData.add(FlSpot(i.hour.toDouble(), i.humid));
      if (i.hour.toDouble() > _maxXTemp) _maxXTemp = i.hour.toDouble();
      if (i.hour.toDouble() > _maxXHumid) _maxXHumid = i.hour.toDouble();
    }
    notifyListeners();
  }
}
