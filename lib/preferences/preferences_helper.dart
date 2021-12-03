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

  Future<String> get userId async {
    final prefs = await sharedPreferences;
    String userId = prefs.getString(userPreferences) ?? '';
    return userId;
  }

  void setUserId(String userId) async {
    final prefs = await sharedPreferences;
    prefs.setString(userPreferences, userId);
  }

  void removeUser() async {
    final prefs = await sharedPreferences;
    prefs.remove(userPreferences);
  }
}
