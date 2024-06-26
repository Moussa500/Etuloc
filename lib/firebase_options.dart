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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBRRpxMofAbUwwNZDnadya2iYzImlqSPi8',
    appId: '1:383715107184:web:c32ef962d0d11e656c2fb5',
    messagingSenderId: '383715107184',
    projectId: 'etuloc-21a55',
    authDomain: 'etuloc-21a55.firebaseapp.com',
    storageBucket: 'etuloc-21a55.appspot.com',
    measurementId: 'G-K815WDQ2CV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYZBMd9LKkVxwhA0OMhljb21N4hCafOBs',
    appId: '1:383715107184:android:e7acbbfa9bb325c86c2fb5',
    messagingSenderId: '383715107184',
    projectId: 'etuloc-21a55',
    storageBucket: 'etuloc-21a55.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6YOL1iEEZI4LZU2MK5YtNpmjfeKrUwq4',
    appId: '1:383715107184:ios:aa62d29361d644906c2fb5',
    messagingSenderId: '383715107184',
    projectId: 'etuloc-21a55',
    storageBucket: 'etuloc-21a55.appspot.com',
    iosBundleId: 'com.example.projetFedere',
  );
}
