import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quest/splash_screen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB1msKwHQB81XB9i_15Gvas2COcHOXbsEo",
            authDomain: "quest-40b45.firebaseapp.com",
            projectId: "quest-40b45",
            storageBucket: "quest-40b45.appspot.com",
            messagingSenderId: "1058419706587",
            appId: "1:1058419706587:web:3c73fe821596461ba65afe"));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
