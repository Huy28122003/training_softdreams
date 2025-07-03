import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  String? get accessToken => _sharedPreferences.getString(_Keys.accessToken);

  String? get versionData => _sharedPreferences.getString(_Keys.versionData);

  Future<bool> saveAccessToken(String token) {
    return _sharedPreferences.setString(_Keys.accessToken, token);
  }

  Future<bool> removeToken() {
    return _sharedPreferences.remove(_Keys.accessToken);
  }

  Future<bool> saveVersionData(String version) {
    return _sharedPreferences.setString(_Keys.versionData, version);
  }
}

class _Keys {
  static const String accessToken = 'accessToken';
  static const String versionData = 'versionData';
}
