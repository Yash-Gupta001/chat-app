import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ChatUser extends StatefulWidget {
  const ChatUser({super.key});

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
        title: Text('HOlaa!'),
        subtitle: Text('this is my last message',maxLines: 1,),
        trailing: Text('12:00am'), 
      ),
    ),
  );
}

}