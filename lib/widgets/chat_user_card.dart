import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/chat_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class ChatUser extends StatefulWidget {
  final ChatUserInfo user;

  const ChatUser({super.key, required this.user});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    // Access the media query
    final mq = MediaQuery.of(context).size;
    
    return Card(
      elevation: 0.6,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * 0.3),
            child: CachedNetworkImage(
              width: mq.height * 0.055,  // Updated to 0.055 to correct the size
              height: mq.height * 0.055,  // Updated to 0.055 to correct the size
              imageUrl: widget.user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          // Username
          title: Text(widget.user.name),
          // Last message
          subtitle: Text(widget.user.about, maxLines: 1),
          // Last message time
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
