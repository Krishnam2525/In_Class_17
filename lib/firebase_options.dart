import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyCU0-938lodj_FveqyaXkDIeB2Z84PKC40",
        appId: "1:928135628896:web:8f1e375c5f7da0ab1a1b05",
        messagingSenderId: "928135628896",
        projectId: "inclass17-5e6b4",
        storageBucket: "inclass17-5e6b4.firebasestorage.app",
        authDomain: "inclass17-5e6b4.firebaseapp.com",
        measurementId: "G-TKMW73TFWZ",
      );
    }

    return const FirebaseOptions(
      apiKey: "AIzaSyCQlpF9J5r8nKSUwYLgQWpyydX_iknYfTI",
      appId: "1:928135628896:android:ec142d9e3acd1b2d1a1b05",
      messagingSenderId: "928135628896",
      projectId: "inclass17-5e6b4",
      storageBucket: "inclass17-5e6b4.firebasestorage.app",
    );
  }
}
