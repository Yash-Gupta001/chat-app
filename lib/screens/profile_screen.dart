import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/models/chat_user_info.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/dialogs.dart';

// Profile screen to show signed-in users
class ProfileScreen extends StatefulWidget {
  final ChatUserInfo userInfo;

  const ProfileScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  String? _image;

  String? _name;
  String? _about;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userInfo.name);
    _aboutController = TextEditingController(text: widget.userInfo.about);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      //for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  //for moving to homescreen
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Space between image and top bar
                  SizedBox(height: mq.height * .03),

                  // User profile picture
                  Stack(
                    children: [
                      // profile picture
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .1),
                        child: _image != null
                            ? Image.file(
                                File(_image!),
                                width: mq.height * .2,
                                height: mq.height * .2,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
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
                        child: MaterialButton(
                          onPressed: () {
                            _showBottomSheet();
                          },
                          elevation: 1,
                          color: Colors.black,
                          shape: CircleBorder(),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
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
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Let the world know your name! 🌍';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),

                  // Space between name and about input
                  SizedBox(height: mq.height * .02),

                  // User about input
                  TextFormField(
                    controller: _aboutController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'About',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Let the world know a bit about you! ✨';
                      }
                      return null;
                    },
                    onSaved: (value) => _about = value,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Save the updated user info
                        Apis.me.name = _name!;
                        Apis.me.about = _about!;
                        Apis.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                            context, 'Profile updated 😇');
                        });
                      }
                    },
                    icon: Icon(Icons.data_thresholding),
                    label: Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    final mq = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: mq.height * .03,
            bottom: mq.height * .05,
          ),
          children: [
            Text(
              'Select Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // for adding some space
            SizedBox(height: mq.height * .03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // camera
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: CircleBorder(),
                    fixedSize: Size(mq.width * .3, mq.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      Apis.updateProfilePicture(File(_image!));
                      // for hiding bottom sheet
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Image.asset('assets/camera.png'),
                ),

                // gallery
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    fixedSize: Size(mq.width * .3, mq.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 80);
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      Apis.updateProfilePicture(File(_image!));
                      // for hiding bottom sheet
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Image.asset('assets/images.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
