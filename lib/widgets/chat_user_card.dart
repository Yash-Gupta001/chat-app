import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/helper/my_date_util.dart';
import 'package:chat_app/models/chat_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../models/message_info.dart';
import '../screens/chat_screen.dart';

class ChatUser extends StatefulWidget {
  final ChatUserInfo user;

  const ChatUser({super.key, required this.user});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {

  Message? _message;

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
        child: StreamBuilder(stream: Apis.getLastMessages(widget.user),builder: (context,snapshot){

          final data = snapshot.data?.docs;
          final list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if(list.isNotEmpty) _message = list[0];
            
    


            return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * 0.3),
            child: CachedNetworkImage(
              width: mq.height * 0.055,  // Updated to 0.055 to correct the size
              height: mq.height * 0.055,  // Updated to 0.055 to correct the size
              imageUrl: widget.user.image,
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          // Username
          title: Text(widget.user.name),

          // Last message
          subtitle: _message != null ?
  _message!.type == Type.image ?
    Row(
      children: [
        Icon(Icons.image), // Image icon
        SizedBox(width: 5), // Add some space between icon and text
        Text('Image'), // Image text
      ],
    )
    :
    Text(_message!.msg, maxLines: 1) // Regular message text
  :
  Text(widget.user.about, maxLines: 1), // Default about text


          // Last message time
          trailing: _message == null ? 
          null // show nothing when no message is sent
          : _message!.read.isEmpty  && _message!.fromId!= Apis.user.uid ?
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          )
          : Text(
            MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
            style: TextStyle(color: Colors.black),
          ),
        );

        },)
      ),
    );
  }
}
