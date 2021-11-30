import 'package:flutter/cupertino.dart';

class InitProvider extends ChangeNotifier {
  int bottomNavIndex = 0;

  void setNavIndex(int index) {
    bottomNavIndex = index;
    notifyListeners();
  }
}
