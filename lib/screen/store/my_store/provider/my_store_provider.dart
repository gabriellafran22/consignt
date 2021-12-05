import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class MyStoreProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  String _userId = '';
  String get userId => _userId;

  MyStoreProvider({required this.preferencesHelper}) {
    _getUserId();
  }

  Future<void> _getUserId() async {
    final user = await preferencesHelper.userId;
    _userId = user;

    notifyListeners();
  }
}
