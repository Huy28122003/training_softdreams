abstract class TokenRepository {
  Future<void> persistToken(String token);

  Future<void> removeToken();

  String? get accessToken;

  bool get isLoggedIn;
}
