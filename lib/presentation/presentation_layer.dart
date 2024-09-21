import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screen/main_screen.dart';
import 'theme.dart' as app_theme;

class PresentationLayer extends StatelessWidget {
  static const debugMode = false;
  static final theme = app_theme.theme;
  static const defaultPath = MainScreen.path;

  const PresentationLayer({super.key});

  /// Pop all routes and replace route with the [defaultPath].
  static void resetRouter(BuildContext context) {
    GoRouter router = GoRouter.of(context);
    while (router.canPop()) {
      router.pop();
    }
    router.replace(defaultPath);
  }

  @override
  Widget build(BuildContext context) {
    // Keep this MaterialApp consistent with SimpleAppWrapper
    return MaterialApp.router(
      debugShowCheckedModeBanner: debugMode,
      theme: theme,
      routerConfig: GoRouter(
        initialLocation: defaultPath,
        routes: [
          MainScreen.route(),
        ],
      ),
    );

    //// Switch above with this after configuring Firebase
    // return AuthGate(
    //   // Keep this MaterialApp consistent with SimpleAppWrapper
    //   child: MaterialApp.router(
    //     debugShowCheckedModeBanner: debugMode,
    //     theme: theme,
    //     routerConfig: GoRouter(
    //       initialLocation: defaultPath,
    //       routes: [
    //         MainScreen.route(),
    //       ],
    //     ),
    //   ),
    // );
  }
}

/// Consolidate theming for other root components, like AuthGate.
class SimpleAppWrapper extends StatelessWidget {
  final Widget? child;

  const SimpleAppWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    // Keep this MaterialApp consistent with PresentationLayer's MaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: PresentationLayer.debugMode,
      theme: PresentationLayer.theme,
      home: child,
    );
  }
}
