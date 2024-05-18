import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/models/chat_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/dialogs.dart';

// Profile screen to show signed-in users
class ProfileScreen extends StatefulWidget {
  final ChatUserInfo userInfo;

  const ProfileScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await Apis.auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
                Navigator.pushReplacement(context, newRoute)
              });
            });
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              // Space between image and top bar
              SizedBox(height: mq.height * .03),


              // User profile picture
              Stack(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .1),
                  child: CachedNetworkImage(
                    width: mq.height * .2,
                    height: mq.height * .2,
                    fit: BoxFit.fill,
                    imageUrl: widget.userInfo.image,
                    errorWidget: (context, url, error) => CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: MaterialButton(onPressed: (){},
                  elevation: 1,
                  color: Colors.black,
                  shape: CircleBorder(),
                  child: Icon(Icons.edit,color: Colors.white),
                  ),
                )
            ],
              ),

              // Space between profile picture and email
              SizedBox(height: mq.height * .03),

              // User email
              Text(
                widget.userInfo.email,
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),

              // Space between email and name input
              SizedBox(height: mq.height * .05),

              // User name input
              TextFormField(
                initialValue: widget.userInfo.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),

              // Space between name and about input
              SizedBox(height: mq.height * .02),

              // User about input
              TextFormField(
                initialValue: widget.userInfo.about,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'About',
                ),
              ),

              // Space between name and about input
              SizedBox(height: mq.height * .05),

              // Update button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(mq.width * .6, mq.height * .07),
                  backgroundColor: Colors.black, // Set background color to black
                  foregroundColor: Colors.white, // Set text and icon color to white
                ),
                onPressed: () {},
                icon: Icon(Icons.data_thresholding),
                label: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
