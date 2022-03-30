import 'package:flutter/cupertino.dart';
import 'package:smart_home/firebase_utils.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LivingRoomState with ChangeNotifier {
  final List<bool> _lightList = [
    false,
    false,
    false,
    false,
  ];
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
        await FirebaseUtils.getLastestRealtimeDatabase(
            {'AccountName': 'gia_cat'});
    var snapshot = returnMessage.data;
    snapshot.listen((event) {
      this._humid = event.docs[0]['air_humidity'].toDouble();
      this._temp = event.docs[0]['env_temperature'].toDouble();
      notifyListeners();
    });
  }

  bool getLightState(int idx) {
    return _lightList[idx];
  }

  double get temp => _temp;

  double get humid => _humid;

  void changeTemperature(double temp) {
    _temp = temp;
    FirebaseUtils.addRealtimeDatabase({
      'AirHumidity': this._humid,
      'EnvTemperature': this._temp,
      'LandHumidity': 0,
      'AccountName': 'gia_cat'
    });
    initValue();
    notifyListeners();
  }

  void changeHumidity(double humid) {
    _humid = humid;
    notifyListeners();
  }

  void changeLightState(int idx, bool value) {
    _lightList[idx] = value;
    // Fluttertoast.showToast(
    //   msg: "This is a Toast message", // message
    //   toastLength: Toast.LENGTH_SHORT, // length
    //   gravity: ToastGravity.CENTER, // location
    //   // duration
    // );
    notifyListeners();
  }
}
