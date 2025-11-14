import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../widgets/notification_dialog.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Function(String type, String text)? onMessageReceived;

  static Future<void> initializeFCM() async {
    await messaging.requestPermission();

    messaging.subscribeToTopic("messaging");

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    FirebaseMessaging.onMessage.listen((msg) {
      final type = msg.data["type"] ?? "regular";
      final text = msg.notification?.body ?? "No message";

      if (onMessageReceived != null) {
        onMessageReceived!(type, text);
      }

      NotificationDialog.show(type, text);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print("Message opened!");
    });
  }

  static Future<String?> getToken() async {
    final token = await messaging.getToken();
    print("FCM TOKEN: $token");
    return token;
  }
}

Future<void> _backgroundHandler(RemoteMessage msg) async {
  print("Background message: ${msg.data}");
}
