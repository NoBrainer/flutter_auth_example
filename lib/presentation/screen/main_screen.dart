import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation_layer.dart';
import 'home_page.dart';

class MainScreen extends StatelessWidget {
  static const String path = '/main';

  static GoRoute route() {
    return GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    );
  }

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: PresentationLayer.theme,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
