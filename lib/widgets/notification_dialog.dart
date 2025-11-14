import 'package:flutter/material.dart';

class NotificationDialog {
  static void show(String type, String message) {
    Color bg;
    IconData icon;

    switch (type) {
      case "important":
        bg = Colors.red.shade100;
        icon = Icons.warning;
        break;
      case "wisdom":
        bg = Colors.purple.shade100;
        icon = Icons.lightbulb;
        break;
      case "motivation":
        bg = Colors.blue.shade100;
        icon = Icons.emoji_events;
        break;
      default:
        bg = Colors.grey.shade200;
        icon = Icons.message;
    }

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
        backgroundColor: bg,
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(type.toUpperCase()),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(navigatorKey.currentContext!),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
