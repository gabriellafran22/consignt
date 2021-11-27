import 'dart:convert';

import 'package:consignt/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const listView = 'listView';
  static const userPreferences = 'user';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isListView async {
    final prefs = await sharedPreferences;
    return prefs.getBool(listView) ?? true;
  }

  void setListView(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(listView, value);
  }

  Future<UserModel?> get user async {
    final prefs = await sharedPreferences;
    String userJson = prefs.getString(userPreferences) ?? '';
    UserModel? userModel =
        userJson == '' ? null : UserModel.fromJson(jsonDecode(userJson));
    return userModel;
  }

  void setUser(UserModel user) async {
    final prefs = await sharedPreferences;
    prefs.setString(userPreferences, userToJson(user));
  }

  void removeUser() async {
    final prefs = await sharedPreferences;
    prefs.remove(userPreferences);
  }
}
