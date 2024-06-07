import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/chat_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Profile screen to show signed-in users
class ViewProfileScreen extends StatefulWidget {
  final ChatUserInfo userInfo;

  const ViewProfileScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // App bar
        appBar: AppBar(title: Text(widget.userInfo.name)),

        // User about
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       'Joined On: ',
        //       style: TextStyle(
        //           color: Colors.black87,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 15),
        //     ),
        //     Text(
        //         MyDateUtil.getLastMessageTime(
        //             context: context,
        //             time: widget.userInfo.createdAt,
        //             showYear: true),
        //         style: const TextStyle(color: Colors.black54, fontSize: 15)),
        //   ],
        // ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // For adding some space
                SizedBox(width: mq.width, height: mq.height * .05),

                // User profile picture with shadow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.cover,
                      imageUrl: widget.userInfo.image,
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: mq.height * .1,
                        child: Icon(CupertinoIcons.person, size: mq.height * .1),
                      ),
                    ),
                  ),
                ),

                // For adding some space
                SizedBox(height: mq.height * .03),

                // User email label
                Text(
                  widget.userInfo.email,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // For adding some space
                SizedBox(height: mq.height * .02),

                // Divider
                Divider(color: Colors.black),

                // For adding some space
                SizedBox(height: mq.height * .02),

                // User about section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'About: ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.userInfo.about,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // For adding some space
                SizedBox(height: mq.height * .05),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.grey[100], // Light background color for the entire screen
      ),
    );
  }
}
