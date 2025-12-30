import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Massagefield extends StatefulWidget {
  const Massagefield({super.key});

  @override
  State<Massagefield> createState() => _MassagefieldState();
}

class _MassagefieldState extends State<Massagefield> {
  File? userImage;
  var enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    final userId = await FirebaseAuth.instance.currentUser;

    // FirebaseStorage.instance.ref().child('UserImages').child()

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId?.uid)
            .get();
    // final userName = userDoc['username'];
    userDoc.data();

    FirebaseFirestore.instance.collection('assitChat').add({
      'chatmsg': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userId?.uid,
      // 'username': userName,
    });
    _controller.clear();
    FocusScope.of(context).unfocus(); // Dismiss the keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(08),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    enteredMessage = value;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Send a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_rounded),
            color: AppColors.secondary,
            onPressed: enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
