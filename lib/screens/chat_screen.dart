import 'dart:developer';
import 'dart:io';

import 'package:chat_app/models/message_info.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:chat_app/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../api/apis.dart';
import '../helper/my_date_util.dart';
import '../models/chat_user_info.dart';
import 'auth/login_screen.dart';

class ChatScreen extends StatefulWidget {
  final ChatUserInfo user;

  ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // for storing messages
  List<Message> _list = [];
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    // Prevent screenshots
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    // Set system UI mode and overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: _appBar(context),
                ),
              ),
            ),
            backgroundColor: Colors.black, // Set Scaffold background to black
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: Apis.getAllMessages(widget.user),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong!',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      switch (snapshot.connectionState) {
                        // if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return SizedBox();

                        // if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                              reverse: true,
                              itemCount: _list.length,
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MessageCard(message: _list[index]);
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'Hola, amigo! 👋',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
                _ChatInput(user: widget.user) // Pass user to _ChatInput
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: Apis.getUserInfo(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list = data?.map((e) => ChatUserInfo.fromJson(e.data())).toList() ?? [];
          return Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.image),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.user.name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    list.isNotEmpty
                        ? list[0].isOnline
                            ? 'Online'
                            : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: list[0].lastActive)
                        : MyDateUtil.getLastActiveTime(
                            context: context,
                            lastActive: widget.user.lastActive),
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChatInput extends StatefulWidget {
  final ChatUserInfo user;

  _ChatInput({required this.user});

  @override
  __ChatInputState createState() => __ChatInputState();
}

class __ChatInputState extends State<_ChatInput> {
  final TextEditingController _textControl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showIcons = true;
  bool _showEmoji = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _showEmoji = false; // Hide emoji picker when text field is focused
        }
        _showIcons = !_focusNode.hasFocus || _textControl.text.isEmpty;
      });
    });
    _textControl.addListener(() {
      setState(() {
        _showIcons = _textControl.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textControl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmoji = !_showEmoji;
      if (_showEmoji) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  children: [
                    //emoji button
                    IconButton(
                      onPressed: _toggleEmojiPicker,
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.white, size: 25),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textControl,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Start Conversation...',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    if (_showIcons)
                      Row(
                        children: [
                          IconButton(
                            // take image from gallery
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final List<XFile> images = await picker.pickMultiImage(imageQuality: 80);
                              for (var i in images) {
                                log('Image Path: ${i.path}');
                                await Apis.sendChatImage(widget.user, File(i.path));
                              }
                            },
                            icon: const Icon(Icons.image, color: Colors.white, size: 25),
                          ),
                          IconButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.camera, imageQuality: 80);
                              if (image != null) {
                                log('Image Path: ${image.path}');
                                await Apis.sendChatImage(widget.user, File(image.path));
                              }
                            },
                            icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 25),
                          ),
                        ],
                      ),

                    MaterialButton(
                      onPressed: () {
                        if (_textControl.text.isNotEmpty) {
                          Apis.sendMessage(widget.user, _textControl.text, Type.text);
                          _textControl.text = '';
                        }
                      },
                      shape: CircleBorder(),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !_showEmoji,
          child: WillPopScope(
            onWillPop: () async {
              if (_showEmoji) {
                setState(() => _showEmoji = false);
                return false; // Prevent navigating back
              } else {
                return true; // Allow navigating back
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  _textControl.text += emoji.emoji;
                },
                textEditingController: _textControl,
                config: Config(
                  emojiViewConfig: EmojiViewConfig(
                    backgroundColor: Colors.black,
                    columns: 8,
                    emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

