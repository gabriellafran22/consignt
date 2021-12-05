import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  bool _isListView = true;
  String _userId = '';

  PreferencesProvider({required this.preferencesHelper}) {
    _getView();
    getUserId();
  }

  bool get isListView => _isListView;

  String get userId => _userId;

  void _getView() async {
    _isListView = await preferencesHelper.isListView;
    notifyListeners();
  }

  void setView(bool value) async {
    preferencesHelper.setListView(value);
    _getView();
  }

  Future<String> getUserId() async {
    _userId = await preferencesHelper.userId;
    notifyListeners();
    return _userId;
  }

  void removeUser() async {
    preferencesHelper.removeUser();
  }
}
