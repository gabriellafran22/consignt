import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const listView = 'listView';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isListView async {
    final prefs = await sharedPreferences;
    return prefs.getBool(listView) ?? true;
  }

  void setListView(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(listView, value);
  }
}
