import 'package:flutter/cupertino.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/sensor_info.dart';

class GardenState with ChangeNotifier {
  List<SensorInform> _lightList = [];
  double _landHumid = 50.0;
  double _airHumid = 10.0;
  double _temp = 16.0;

  double _targetHumid = 0.0;

  final bool _isControlTemp = false;
  final bool _isControlHumid = true;

  bool get isControlTemp => _isControlTemp;

  bool get isControlHumid => _isControlHumid;

  final String _imgUrl = 'assets/images/garden.jpg';

  bool getLightState(int idx) {
    return _lightList[idx].state == 'on';
  }

  String get imgUrl => _imgUrl;

  double get temp => _temp;

  double get landHumid => _landHumid;

  double get airHumid => _airHumid;

  double get targetHumid => _targetHumid;

  GardenState() {
    initValue();
  }

  void initValue() async {
    ReturnMessage returnMessage =
        await FirebaseUtils.getLastestRealtimeDatabase({
      'AccountName': 'giacat',
      'Area': 'garden',
    });
    var snapshot = returnMessage.data;
    snapshot.listen((event) {
      _landHumid = event.docs[0]['land_humidity'].toDouble();
      _temp = event.docs[0]['env_temperature'].toDouble();
      _airHumid = event.docs[0]['air_humidity'].toDouble();
      _targetHumid = _landHumid;
      notifyListeners();
    });

    ReturnMessage msg = await FirebaseUtils.getAreaSensors({
      'AccountName': 'giacat',
      'Area': 'garden',
    });
    var lightSnapshot = msg.data;
    lightSnapshot.listen((event) {
      _lightList = [];
      event.docs.forEach((e) {
        _lightList.add(SensorInform(
          e['area'],
          e['name'],
          e['sensor_id'],
          e['account_name'],
          e['state'],
        ));
      });
      _lightList.sort((a, b) => a.sensor_id.compareTo(b.sensor_id));
      notifyListeners();
    });
  }

  void changeHumidity(double humid) async {
    _targetHumid = humid;
    FirebaseUtils.setTargetEnv({
      'AccountName': 'giacat',
      'SensorId': 19,
      'LandHumidity': humid.toInt(),
    });
    notifyListeners();
  }

  void changeLightState(int idx, bool value) {
    _lightList[idx].state = value ? 'on' : 'off';
    if (value) {
      FirebaseUtils.turnOnSensor(
          {'AccountName': 'giacat', 'SensorId': _lightList[idx].sensor_id});
    } else {
      FirebaseUtils.turnOffSensor(
          {'AccountName': 'giacat', 'SensorId': _lightList[idx].sensor_id});
    }
    notifyListeners();
  }
}
