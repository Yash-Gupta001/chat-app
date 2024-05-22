import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/models/message_info.dart';
import 'package:chat_app/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/apis.dart';
import '../models/chat_user_info.dart';

class ChatScreen extends StatelessWidget {
  List<Message> _list = [];
  final ChatUserInfo user;

  ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Set system UI mode and overlay style
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(context),
          ),
        ),
      ),


      backgroundColor: Colors.black, // Set Scaffold background to black
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Apis.getAllMessages(widget.user),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  // if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());

                  // if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    log('Data: ${jsonEncode(data![0].data())}');
                    // _list = data
                    //         ?.map((e) => Message.fromJson(e.data()))
                    //         .toList() ??
                    //
                    _list.clear();
                    _list.add(Message(
                        toId: 'user1',
                        msg: 'Hello',
                        read: 'false',
                        type: Type.text,
                        fromId: Apis.user.uid,
                        sent:'12:05'));
                    _list.add(Message(
                        toId: Apis.user.uid,
                        msg: 'How are you?',
                        read: 'false',
                        type: Type.text,
                        fromId: 'abc',
                        sent:'12:05'));

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: _list.length,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .01),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MessageCard(message: _list[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Say Hii! 👋',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white), // Set text color to white
                        ),
                      );
                    }
                }
              },
            ),
          ),
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
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Set icon color to white
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16), // Set text color to white
              ),
              Text(
                'last seen',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12), // Set text color to white
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatInput extends StatefulWidget {
  @override
  __ChatInputState createState() => __ChatInputState();
}

class __ChatInputState extends State<_ChatInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showIcons = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showIcons = !_focusNode.hasFocus || _controller.text.isEmpty;
      });
    });
    _controller.addListener(() {
      setState(() {
        _showIcons = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          8.0, 8.0, 8.0, 16.0), // Added bottom padding for spacing
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions,
                  color: Colors.white, size: 25),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Start Conversation...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_showIcons)
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.image, color: Colors.white, size: 25),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 25),
                  ),
                ],
              ),
            MaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
