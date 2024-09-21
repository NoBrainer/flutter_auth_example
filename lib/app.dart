import 'package:flutter/material.dart';

import 'bloc/business_logic_layer.dart';
import 'presentation/presentation_layer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLogicLayer(
      child: const PresentationLayer(),
    );
  }
}
