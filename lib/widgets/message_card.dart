import 'package:flutter/material.dart';
import 'package:chat_app/models/message_info.dart';
import '../api/apis.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context); // Initialize mq here

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Apis.user.uid == widget.message.fromId ? _sentMessage() : _receivedMessage(),
    );
  }

  // Sender message
  Widget _sentMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(mq.size.width * .04), // Use mq.size.width
        margin: EdgeInsets.symmetric(vertical: mq.size.height * .01, horizontal: mq.size.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.message.msg,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4), // Add some space between the message and the timestamp
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.message.sent,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(width: 4),
                Icon(Icons.done_all_rounded,color: Colors.white,size: 20,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Receiver message
  Widget _receivedMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Flexible(
        child: Container(
          padding: EdgeInsets.all(mq.size.width * .04), // Use mq.size.width
          margin: EdgeInsets.symmetric(vertical: mq.size.height * .01, horizontal: mq.size.width * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Message
              Text(
                widget.message.msg,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4), // Add some space between the message and the timestamp
              // Timestamp and double tick
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.message.sent,
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.done_all_rounded,color: Colors.black,size: 20,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
