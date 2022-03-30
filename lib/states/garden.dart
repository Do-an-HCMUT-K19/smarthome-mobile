import 'package:flutter/cupertino.dart';
import 'package:smart_home/firebase_utils.dart';

class GardenState with ChangeNotifier {
  final List<bool> _lightList = [
    false,
    false,
  ];
  double _humid = 10.0;
  double _temp = 16.0;

  final bool _isControlTemp = false;
  final bool _isControlHumid = true;

  bool get isControlTemp => _isControlTemp;

  bool get isControlHumid => _isControlHumid;

  final String _imgUrl = 'assets/images/garden.jpg';

  bool getLightState(int idx) {
    return _lightList[idx];
  }

  String get imgUrl => _imgUrl;

  double get temp => _temp;

  double get humid => _humid;

  GardenState() {
    initValue();
  }

  void initValue() async {
    ReturnMessage returnMessage =
        await FirebaseUtils.getLastestRealtimeDatabase(
            {'AccountName': 'giacat'});
    var snapshot = returnMessage.data;
    print(snapshot);
    snapshot.listen((event) {
      this._humid = event.docs[0]['air_humidity'].toDouble();
      this._temp = event.docs[0]['env_temperature'].toDouble();
    });
    print('done');
    notifyListeners();
  }

  void changeTemperature(double temp) {
    _temp = temp;
    notifyListeners();
  }

  void changeHumidity(double humid) async {
    _humid = humid;
    await FirebaseUtils.addRealtimeDatabase({
      'AirHumidity': this._humid,
      'EnvTemperature': this._temp,
      'LandHumidity': 0,
      'AccountName': 'gia_cat'
    });
    initValue();
  }

  void changeLightState(int idx, bool value) {
    _lightList[idx] = value;
    print(value);
    notifyListeners();
  }
}
