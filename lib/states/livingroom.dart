import 'package:flutter/cupertino.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/sensor_info.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LivingRoomState with ChangeNotifier {
  final List<SensorInform> _lightList = [];
  double _humid = 10.0;
  double _temp = 16.0;

  final bool _isControlTemp = false;
  final bool _isControlHumid = false;

  final String _imgUrl = 'assets/images/livingroom.jpg';

  String get imgUrl => _imgUrl;

  bool get isControlTemp => _isControlTemp;

  bool get isControlHumid => _isControlHumid;

  LivingRoomState() {
    // FirebaseUtils.getLastestRealtimeDatabase({'AccountName': 'giacat'})
    //     .then((value) {
    //   print(value.code.data);
    // });
    initValue();
  }

  void initValue() async {
    ReturnMessage returnMessage =
        await FirebaseUtils.getLastestRealtimeDatabase({
      'AccountName': 'giacat',
      'Area': 'living_room',
    });
    var snapshot = returnMessage.data;
    snapshot.listen((event) {
      this._humid = event.docs[0]['air_humidity'].toDouble();
      this._temp = event.docs[0]['env_temperature'].toDouble();
      notifyListeners();
    });
    ReturnMessage msg = await FirebaseUtils.getAreaSensors({
      'AccountName': 'giacat',
      'Area': 'living_room',
    });
    for (var element in msg.data.sensors) {
      _lightList.add(element);
    }
    _lightList.sort((a, b) => a.sensor_id >= b.sensor_id ? 1 : 0);
  }

  bool getLightState(int idx) {
    return _lightList[idx].state == 'on';
  }

  double get temp => _temp;

  double get humid => _humid;

  void changeTemperature(double temp) async {
    _temp = temp;
    updateDataFirebase();
    notifyListeners();
  }

  void changeHumidity(double humid) {
    _humid = humid;
    updateDataFirebase();
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

  void updateDataFirebase() async {
    await FirebaseUtils.addRealtimeDatabase({
      'AirHumidity': this._humid,
      'EnvTemperature': this._temp,
      'LandHumidity': 0,
      'AccountName': 'giacat',
      'Area': 'living_room',
    });
  }
}
