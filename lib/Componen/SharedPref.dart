import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  setData(String name, String value) async {
    SharedPreferences pref = await _prefs;
    await pref.setString(name, value);
    print("[pref saved]");
  }

  Future<String> getData(String name) async {
    SharedPreferences pref = await _prefs;
    String c = await pref.getString(name).toString();
    return c;
  }
}
