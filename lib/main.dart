import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'services/notification_service.dart';
import 'widgets/notification_card.dart';
import 'widgets/notification_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 FIX: Request Notification Permission FIRST
  await FirebaseMessaging.instance.requestPermission();

  // 🔥 Init Firebase AFTER permissions
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 Set up FCM handlers
  NotificationService.initializeFCM();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Required for showing dialogs from background/foreground FCM
      navigatorKey: navigatorKey,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),

      home: const NotificationHome(),
    );
  }
}

class NotificationHome extends StatefulWidget {
  const NotificationHome({super.key});

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  String? fcmToken = "Loading...";
  String messageText = "Waiting for message...";
  String messageType = "none";

  @override
  void initState() {
    super.initState();

    // Listen to incoming messages
    NotificationService.onMessageReceived = (type, text) {
      setState(() {
        messageType = type;
        messageText = text;
      });
    };

    // Load FCM Token
    NotificationService.getToken().then((token) {
      setState(() => fcmToken = token ?? "No Token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FCM Notifications Demo"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your FCM Token:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              fcmToken ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Last Notification:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          NotificationCard(
            type: messageType,
            message: messageText,
          ),
        ],
      ),
    );
  }
}
