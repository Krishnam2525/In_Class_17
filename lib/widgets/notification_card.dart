import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String type;
  final String message;

  const NotificationCard(
      {super.key, required this.type, required this.message});

  Color _background() {
    switch (type) {
      case "important":
        return Colors.red.shade300;
      case "wisdom":
        return Colors.purple.shade300;
      case "motivation":
        return Colors.blue.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  IconData _icon() {
    switch (type) {
      case "important":
        return Icons.warning;
      case "wisdom":
        return Icons.lightbulb;
      case "motivation":
        return Icons.emoji_events;
      default:
        return Icons.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: _background(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(_icon(), size: 35),
          const SizedBox(width: 10),
          Expanded(child: Text(message, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
