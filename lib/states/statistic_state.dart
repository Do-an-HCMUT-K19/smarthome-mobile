import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/models/return_msg.dart';

class StatisticState with ChangeNotifier {
  DateTime _chosenDate = DateTime.now();

  List<FlSpot> _tempData = [];
  List<FlSpot> _humidLandData = [];
  List<FlSpot> _humidAirData = [];

  double _maxXHumidLand = 10;
  double _maxXHumidAir = 10;

  double _maxXTemp = 10;

  List<FlSpot> get tempData => _tempData;
  List<FlSpot> get humidLandData => _humidLandData;
  List<FlSpot> get humidAirData => _humidAirData;

  double get maxXHumidAir => _maxXHumidAir;
  double get maxXHumidLand => _maxXHumidLand;
  double get maxXTemp => _maxXTemp;

  DateTime get chosenDate => _chosenDate;

  Future<void> renewData(RoomType roomType, DateTime time) async {
    _tempData = [];
    _humidLandData = [];
    _humidAirData = [];
    _chosenDate = time;
    _maxXHumidAir = 10;
    _maxXHumidLand = 10;
    _maxXTemp = 10;
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
    for (var i in returnMessage.data) {
      _tempData.add(FlSpot(i.hour.toDouble(), i.temp));
      _humidLandData.add(FlSpot(i.hour.toDouble(), i.landHumid));
      _humidAirData.add(FlSpot(i.hour.toDouble(), i.airHumid));
      if (i.hour.toDouble() > _maxXTemp) _maxXTemp = i.hour.toDouble();
      if (i.hour.toDouble() > _maxXHumidAir) _maxXHumidAir = i.hour.toDouble();
      if (i.hour.toDouble() > _maxXHumidLand)
        _maxXHumidLand = i.hour.toDouble();
    }
    notifyListeners();
  }
}
