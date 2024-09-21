import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repository/auth_repository.dart';
import '../../util/log_util.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser == null
              ? const AuthState.unauthenticated()
              : AuthState.authenticated(authRepository.currentUser!),
        ) {
    on<_UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(_UserChanged(user)),
    );
  }

  void _onUserChanged(_UserChanged event, Emitter<AuthState> emit) {
    debug("AuthBloc._onUserChanged()");
    emit(
      event.user == null
          ? const AuthState.unauthenticated()
          : AuthState.authenticated(event.user!),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    debug("AuthBloc._onLogoutRequested()");
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
