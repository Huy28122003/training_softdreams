import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/error/failures.dart';
import '../../../domain/usecases/auth/delete_token.dart';
import '../../../domain/usecases/auth/get_authorized_user.dart';
import '../../../utils/constants/strings.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthorizedUser getAuthorizedUser;
  final DeleteToken deleteToken;

  AuthBloc({
    required this.getAuthorizedUser,
    required this.deleteToken,
  }) : super(const AuthState.unknown()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthStarted(
      AuthStarted event, Emitter<AuthState> emit) async {
    emit(const AuthState.unknown());

    final result = await getAuthorizedUser();
    await Future.delayed(const Duration(milliseconds: 1500));

    return emit(await result.fold(
      (failure) async {
        if (failure is AuthenticationFailure) {
          await deleteToken();
          return const AuthState.unauthenticated();
        }

        return const AuthState.unknown(message: systemError);
      },
      (user) {
        return AuthState.authenticated(user);
      },
    ));
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(AuthState.authenticated(event.user));
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await deleteToken();
    emit(const AuthState.unauthenticated());
  }

  void onStart() {
    add(const AuthStarted());
  }

  void logout() {
    add(const AuthLogoutRequested());
  }
}
