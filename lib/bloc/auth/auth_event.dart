part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

final class _UserChanged extends AuthEvent {
  final User? user;

  const _UserChanged(this.user);
}
