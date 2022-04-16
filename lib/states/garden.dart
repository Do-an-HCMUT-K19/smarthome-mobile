import 'package:flutter/cupertino.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/sensor_info.dart';

class GardenState with ChangeNotifier {
  List<SensorInform> _lightList = [];
  double _humid = 10.0;
  double _temp = 16.0;

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

  double get humid => _humid;

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
    print(snapshot);
    snapshot.listen((event) {
      this._humid = event.docs[0]['air_humidity'].toDouble();
      this._temp = event.docs[0]['env_temperature'].toDouble();
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

  void changeTemperature(double temp) {
    _temp = temp;
    updateDataFirebase();
    notifyListeners();
    initValue();
  }

  void changeHumidity(double humid) async {
    _humid = humid;
    updateDataFirebase();
    initValue();
  }

  void updateDataFirebase() async {
    await FirebaseUtils.addRealtimeDatabase({
      'AirHumidity': this._humid,
      'EnvTemperature': this._temp,
      'LandHumidity': 0,
      'AccountName': 'giacat',
      'Area': 'garden',
    });
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
