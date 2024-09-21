import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide AuthState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../presentation_layer.dart';
import 'auth_header.dart';

class AuthGate extends StatefulWidget {
  final Widget child;

  const AuthGate({required this.child, super.key});

  @override
  State<StatefulWidget> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Timer? _userReloadTimer;

  /// Reload the user in 5 seconds
  void scheduleUserReload() {
    _userReloadTimer = Timer(const Duration(seconds: 5), () {
      FirebaseAuth.instance.currentUser?.reload();
    });
  }

  /// Cancel the user reload timer
  void cancelUserReload() {
    _userReloadTimer?.cancel();
    _userReloadTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut(); //uncomment to force logout
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        cancelUserReload();

        // Require login
        if (authState.status == AuthStatus.unauthenticated) {
          return const SimpleAppWrapper(
            child: SignInScreen(headerBuilder: AuthHeader.builder),
          );
        }

        // Require email verification
        User user = authState.user!;
        if (!user.emailVerified) {
          scheduleUserReload();
          return SimpleAppWrapper(
            child: EmailVerificationScreen(
              headerBuilder: AuthHeader.builder,
              actions: [
                AuthCancelledAction((context) {
                  FirebaseAuth.instance.signOut();
                }),
              ],
            ),
          );
        }

        // All authentication requirements met
        return widget.child;
      },
    );
  }

  @override
  void dispose() {
    cancelUserReload();
    super.dispose();
  }
}
