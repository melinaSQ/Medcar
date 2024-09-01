// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBCy-zdZH0AqbRzTw5pv5JdXTD4nKgqb4c',
    appId: '1:282424373748:web:39725daec544a7186209a1',
    messagingSenderId: '282424373748',
    projectId: 'medcar-cb857',
    authDomain: 'medcar-cb857.firebaseapp.com',
    storageBucket: 'medcar-cb857.appspot.com',
    measurementId: 'G-8LCPR1RN50',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDu0apgia-Jb23c50bJGxqXDd9gZVTezps',
    appId: '1:282424373748:android:41cea4f773a89e906209a1',
    messagingSenderId: '282424373748',
    projectId: 'medcar-cb857',
    storageBucket: 'medcar-cb857.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2JbqX81eJduvS_xPl1flw7PPIRh_LyLw',
    appId: '1:282424373748:ios:e05a662739920a6f6209a1',
    messagingSenderId: '282424373748',
    projectId: 'medcar-cb857',
    storageBucket: 'medcar-cb857.appspot.com',
    iosBundleId: 'com.example.medcarBasico',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2JbqX81eJduvS_xPl1flw7PPIRh_LyLw',
    appId: '1:282424373748:ios:e05a662739920a6f6209a1',
    messagingSenderId: '282424373748',
    projectId: 'medcar-cb857',
    storageBucket: 'medcar-cb857.appspot.com',
    iosBundleId: 'com.example.medcarBasico',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBCy-zdZH0AqbRzTw5pv5JdXTD4nKgqb4c',
    appId: '1:282424373748:web:1f8b0a8ec18a23576209a1',
    messagingSenderId: '282424373748',
    projectId: 'medcar-cb857',
    authDomain: 'medcar-cb857.firebaseapp.com',
    storageBucket: 'medcar-cb857.appspot.com',
    measurementId: 'G-P4W42GJ7TW',
  );
}
