import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const sharedPrefTokenKey = 'token';
  static const sharedPrefCurrentUserKey = 'current_user_key';
  static const sharedPrefMyProfileKey = 'my_profile_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  Future saveToken(String token) {
    return _saveToPreferences(sharedPrefTokenKey, token);
  }

  Future<String> getToken() {
    return _getStringFromPreferences(sharedPrefTokenKey);
  }

  Future<bool> isLoggenIn() async {
    return await getToken().then((value) => value.isNotEmpty);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }

  void removeCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPrefCurrentUserKey);
  }

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPrefTokenKey);
  }
}
