import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/message_info.dart';
import '../api/apis.dart';
import '../helper/my_date_util.dart';

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

  // user message
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
            widget.message.type == Type.text ?
            Text(
              widget.message.msg,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ) : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),


            SizedBox(height: 4), // Add some space between the message and the timestamp
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // message sent time
                Text(
                  MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                ),
                SizedBox(width: 4),
                if (widget.message.read.isNotEmpty)
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

    // to update read time
    if(widget.message.read.isEmpty){
      Apis.updateMessageReadStatus(widget.message);
    }


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
              widget.message.type == Type.text?
              Text(
                widget.message.msg,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ) : ClipRRect(
                    //borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),



              SizedBox(height: 4), // Add some space between the message and the timestamp
              // Timestamp and double tick

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
                      style: const TextStyle(fontSize: 8, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 3),
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
