import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  //// TODO: Configure Firebase to work with this project.
  //// TODO: After that is done, you need to uncomment this then
  //// TODO: change PresentationLayer to use the AuthGate.
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  //// TODO: After that is done, you can look into using an auth emulator
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const App());
}
