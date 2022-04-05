import 'package:flutter/cupertino.dart';
import 'package:smart_home/firebase_utils.dart';

class KitchenState with ChangeNotifier {
  final List<SensorInform> _lightList = [];
  double _humid = 10.0;
  double _temp = 16.0;

  final bool _isControlTemp = false;
  final bool _isControlHumid = false;

  bool get isControlTemp => _isControlTemp;

  bool get isControlHumid => _isControlHumid;

  final String _imgUrl = 'assets/images/kitchen.jpg';

  String get imgUrl => _imgUrl;

  bool getLightState(int idx) {
    return _lightList[idx].state == 'on';
  }

  KitchenState() {
    initValue();
  }

  void initValue() async {
    ReturnMessage returnMessage =
        await FirebaseUtils.getLastestRealtimeDatabase({
      'AccountName': 'giacat',
      'Area': 'kitchen',
    });
    var snapshot = returnMessage.data;
    snapshot.listen((event) {
      this._humid = event.docs[0]['air_humidity'].toDouble();
      this._temp = event.docs[0]['env_temperature'].toDouble();
      notifyListeners();
    });
    ReturnMessage msg = await FirebaseUtils.getAreaSensors({
      'AccountName': 'giacat',
      'Area': 'kitchen',
    });
    for (var element in msg.data.sensors) {
      _lightList.add(element);
    }
  }

  double get temp => _temp;

  double get humid => _humid;

  void changeTemperature(double temp) {
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
      'Area': 'kitchen',
    });
  }
}
