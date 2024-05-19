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
  List<ChatUserInfo> _list = [];
  final List<ChatUserInfo> _searchList = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Apis.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        // onWillPop: () {
        //   if (_isSearching) {
        //     setState(() {
        //       _isSearching = !_isSearching;
        //     });
        //     return Future.value(false);
        //   } else {
        //     return Future.value(true);
        //   }
        // },

        //if search is on & back button is pressed then close search
        //or else simple close current screen on back button click
        canPop: !_isSearching,
        onPopInvoked: (_) async {
          if (_isSearching) {
            setState(() => _isSearching = !_isSearching);
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name or Email',
                      hintStyle: TextStyle(color: Colors.white), // Change hint text color to white
                    ),
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 0.5,
                      color: Colors.white, // Change input text color to white
                    ),
                    onChanged: (val) {
                      _searchList.clear();
                      for (var user in _list) {
                        if (user.name.toLowerCase().contains(val.toLowerCase()) ||
                            user.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(user);
                        }
                      }
                      setState(() {}); // Update the UI
                    },
                  )
                : Text('ChatPulse', style: TextStyle(color: Colors.white)), // Change text color to white
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(_isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen(userInfo: Apis.me)),
                  );
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              child: Icon(Icons.message_outlined),
            ),
          ),
          body: StreamBuilder(
            stream: Apis.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final data = snapshot.data?.docs;
                _list = data?.map((e) => ChatUserInfo.fromJson(e.data())).toList() ?? [];

                if (_list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _isSearching ? _searchList.length : _list.length,
                    padding: EdgeInsets.only(top: mq.height * 0.03),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUser(user: _isSearching ? _searchList[index] : _list[index]);
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Connections Found! 💔',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Change text color to white
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
