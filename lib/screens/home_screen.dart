import 'package:chat_app/models/chat_user_info.dart';
import 'package:chat_app/screens/profile_screen.dart';
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

  List<ChatUserInfo> list = [];

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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userInfo: list[0])));
            },
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
          switch (snapshot.connectionState) {
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data?.map((e) => ChatUserInfo.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * 0.03),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUser(user: list[index]);
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No Connections Found! 💔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
