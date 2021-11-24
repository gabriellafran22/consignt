import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const LIST_VIEW = 'LIST_VIEW';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isListView async {
    final prefs = await sharedPreferences;
    return prefs.getBool(LIST_VIEW) ?? true;
  }

  void setListView(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(LIST_VIEW, value);
  }

}