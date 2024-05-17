import 'package:chat_app/models/chat_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ChatUser extends StatefulWidget {

  final ChatUserInfo user;


  const ChatUser({super.key, required this.user});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
  return Card(
    elevation: 0.6,
    child: InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
        //username
        title: Text(widget.user.name),

        //last message
        subtitle: Text(widget.user.about,maxLines: 1,),

        //last message time
        trailing: Text('12:00am'), 
      ),
    ),
  );
}

}