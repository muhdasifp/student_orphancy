import 'package:care_life/utility/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final String sender;
  final String message;
  final Timestamp time;

  const ChatBubble({
    super.key,
    required this.alignment,
    required this.color,
    required this.sender,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        margin: const EdgeInsets.only(top: 3),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sender == 'admin'
                ? Text(sender,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))
                : Text(sender, style: const TextStyle(color: Colors.blue)),
            RichText(
              text: TextSpan(
                text: message,
                style: const TextStyle(fontSize: 17, color: Colors.black),
                children: [
                  TextSpan(
                    text: timeFormatter(time),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
