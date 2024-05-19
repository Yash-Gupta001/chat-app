
import 'package:chat_app/widgets/chat_user.dart';
import 'package:flutter/material.dart';

import '../models/chat_user_info.dart';

class ChatScreen extends StatelessWidget {
  final ChatUserInfo user;

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(context),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 248, 255),
      body: Column(
        children: [
          _ChatInput()
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(user.image),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'last seen',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _ChatInput(){
  return Row(
    children: [
      //emoji button
                  IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.black, size: 25)),

      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Start Conversation...',
            border: InputBorder.none
          ),
        )
        ),

      //file button
                  IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.black, size: 25)),

      //camera button
                  IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.black, size: 25)),

    ],
  );
}

