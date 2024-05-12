import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key); // Corrected the constructor

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Corrected the placement of AppBar
        leading: Icon(CupertinoIcons.home),
        title: Text('Chat App'),
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
        child: FloatingActionButton(onPressed: (){},
        child : Icon(Icons.message_outlined)
        ),
      ),
      body: Container(), 
    );
  }
}
