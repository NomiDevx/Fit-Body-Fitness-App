import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbfitnessapp/chats/messageBubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatmessage extends StatelessWidget {
  const Chatmessage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('assitChat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (context, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final docs = chatSnapShot.data?.docs ?? [];

        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final message = docs[index]['chatmsg'];
            final userId = docs[index]['userId'];
            final timestamp = docs[index]['createdAt'] as Timestamp;
            final isMe = currentUserId == userId;
            return MessageBubble(
              data: message,
              userId: userId,
              time: timestamp.toDate(),
              isMe: isMe,
            );
          },
        );
      },
    );
  }
}
