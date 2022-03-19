import 'package:flutter/cupertino.dart';

class BottomBarState with ChangeNotifier {
  int _chosenPage = 0;

  int get chosenPage => _chosenPage;

  void changePage(int idx) {
    _chosenPage = idx;
    notifyListeners();
  }
}
