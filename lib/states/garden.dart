import 'package:flutter/cupertino.dart';

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

  void changeTemperature(double temp) {
    _temp = temp;
    notifyListeners();
  }

  void changeHumidity(double humid) {
    _humid = humid;
    notifyListeners();
  }

  void changeLightState(int idx, bool value) {
    _lightList[idx] = value;
    print(value);
    notifyListeners();
  }
}
