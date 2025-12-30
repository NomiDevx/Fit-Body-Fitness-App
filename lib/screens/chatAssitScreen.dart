import 'package:fbfitnessapp/chats/chatMessage.dart';
import '../chats/msgInputField.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';

class Chatassitscreen extends StatefulWidget {
  const Chatassitscreen({super.key});

  @override
  State<Chatassitscreen> createState() => _ChatassitscreenState();
}

class _ChatassitscreenState extends State<Chatassitscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        // toolbarHeight: 110,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_left),
                        color: AppColors.secondary,
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.heading,
                        child: Icon(
                          Icons.support_agent_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assistant',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.heading,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'I\'m here to assist you',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Chatmessage()), Massagefield()],
        ),
      ),
    );
  }
}
