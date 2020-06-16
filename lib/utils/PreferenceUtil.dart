import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  Future<SharedPreferences> _prefs;

  PreferenceUtil._() {
    _prefs = SharedPreferences.getInstance();
  }

  static final PreferenceUtil instance = PreferenceUtil._();

  Future<String> getLastLoggedInUsername() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('LastLoggedInUsername');
  }

  void setLastLoggedInUsername(String username) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('LastLoggedInUsername', username);
  }
}
