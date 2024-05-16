import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../widgets/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('ChatPulse'),
        actions: [
          IconButton(
            // search button
            onPressed: () {}, 
            icon: Icon(Icons.search),
          ),
          IconButton(
            //more options button
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      // floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black, // Set background color to black
          foregroundColor: Colors.white, // Set icon color to white
          child: Icon(Icons.message_outlined),
        ),
      ),
      body: StreamBuilder(
        stream: Apis.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            log('Data: $data');
          }
          return ListView.builder(
            itemCount: 20,
            padding: EdgeInsets.only(top: mq.height * 0.03),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatUser();
            },
          );
        },
      ),
    );
  }
}
