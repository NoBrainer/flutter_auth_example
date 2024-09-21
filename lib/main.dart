import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // This is what I got working after setting up things in Firebase console.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  runApp(const App());
}
