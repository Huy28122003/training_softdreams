import '../../domain/repository/token_repository.dart';
import '../local/preference/app_preferences.dart';

class TokenRepositoryImpl extends TokenRepository {
  TokenRepositoryImpl(this._preferences);

  final AppPreferences _preferences;

  @override
  String? get accessToken => _preferences.accessToken;

  @override
  Future<void> persistToken(String token) =>
      _preferences.saveAccessToken(token);

  @override
  Future<void> removeToken() async {
    await _preferences.removeToken();
  }

  @override
  bool get isLoggedIn => _preferences.accessToken != null;
}
