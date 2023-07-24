// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1msKwHQB81XB9i_15Gvas2COcHOXbsEo',
    appId: '1:1058419706587:web:3c73fe821596461ba65afe',
    messagingSenderId: '1058419706587',
    projectId: 'quest-40b45',
    authDomain: 'quest-40b45.firebaseapp.com',
    storageBucket: 'quest-40b45.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBi67ejPqP6WEyuwN6Viv249ZwB6CwS2aw',
    appId: '1:1058419706587:android:d7470ab8d3437c37a65afe',
    messagingSenderId: '1058419706587',
    projectId: 'quest-40b45',
    storageBucket: 'quest-40b45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeHj58lo1fuoglCUTt4gC8njPEYs-40jg',
    appId: '1:1058419706587:ios:26ae604c563d4324a65afe',
    messagingSenderId: '1058419706587',
    projectId: 'quest-40b45',
    storageBucket: 'quest-40b45.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeHj58lo1fuoglCUTt4gC8njPEYs-40jg',
    appId: '1:1058419706587:ios:26ae604c563d4324a65afe',
    messagingSenderId: '1058419706587',
    projectId: 'quest-40b45',
    storageBucket: 'quest-40b45.appspot.com',
    iosBundleId: 'com.example.login',
  );
}
