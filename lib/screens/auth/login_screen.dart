import 'dart:developer';
import 'dart:io';

import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((userCredential) {
      //for hiding progress bar
      Navigator.pop(context);
      if (userCredential != null){
        log('\nUser: ${userCredential.user}');
      log('\nUserAdditionalInfo: ${userCredential.additionalUserInfo}');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = 
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await Apis.auth.signInWithCredential(credential);
    }
    catch(e){
      log('\n_signInWithGoogle:$e');
      Dialogs.showSnackbar(context, 'Please check your internet connection and try again');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ChatPulse'),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5, // Slide in/out animation based on _isAnimate value
            width: mq.width * .5,
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _isAnimate ? 1.0 : 0.0, // Fade in/out animation based on _isAnimate value
              child: Image.asset('assets/talking.png'),
            ),
          ),

          Positioned(
            bottom: mq.height * 0.15,
            left: mq.width * 0.05,
            width: mq.width * 0.9,
            height: mq.height * 0.07,
            child: ElevatedButton.icon(
              onPressed: _handleGoogleBtnClick,
              icon: SizedBox(
                height: mq.height * 0.07,
                child: SvgPicture.asset(
                  'assets/sign.svg',
                ),
              ),
              label: Text(
                'Log in with Google',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
