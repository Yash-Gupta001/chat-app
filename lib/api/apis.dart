import 'package:chat_app/models/chat_user_info.dart';
import 'package:chat_app/widgets/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class Apis{
  //fro authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // to return current user
  static User get user => auth.currentUser!;

  // for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore .collection('users').doc(auth.currentUser!.uid).get()).exists;
  }

  //for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUserInfo(
    image: user.photoURL.toString(),
    about: "Hey, I'm using ChatPulse!",
    name: user.displayName.toString(),
    createdAt: '',
    isOnline: false,
    id: user.uid,
    lastActive: '',
    email: user.email.toString(),
    pushToken: ''
    );
    return await firestore .collection('users').doc(user.uid).set(chatUser.toJson());
  }
}

