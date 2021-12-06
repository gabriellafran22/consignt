import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  bool _isListView = true;
  bool _isListViewInFavorites = true;
  String _userId = '';

  PreferencesProvider({required this.preferencesHelper}) {
    _getView();
    getUserId();
  }

  bool get isListView => _isListView;

  bool get isListViewInFavorites => _isListViewInFavorites;

  String get userId => _userId;

  void _getView() async {
    _isListView = await preferencesHelper.isListView;
    _isListViewInFavorites = await preferencesHelper.isListViewInFavorites;
    notifyListeners();
  }

  void setView(bool value) async {
    preferencesHelper.setListView(value);
    _getView();
  }

  void setViewInFavorites(bool value) async {
    preferencesHelper.setListViewInFavorites(value);
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
