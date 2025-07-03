part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged({
    required this.user,
  });

  final String user;
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
