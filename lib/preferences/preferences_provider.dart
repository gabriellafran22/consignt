import 'package:consignt/core/model/user.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  bool _isListView = true;

  PreferencesProvider({required this.preferencesHelper}) {
    _getView();
  }

  bool get isListView => _isListView;

  void _getView() async {
    _isListView = await preferencesHelper.isListView;
    notifyListeners();
  }

  void setView(bool value) async {
    preferencesHelper.setListView(value);
    _getView();
  }

  Future<UserModel?> getUser() async {
    final user = await preferencesHelper.user;
    notifyListeners();
    return user;
  }

  void removeUser() async {
    preferencesHelper.removeUser();
  }
}
