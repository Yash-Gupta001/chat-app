import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/services.dart';
import '../api/apis.dart';
import 'auth/login_screen.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // Call the method to navigate to home screen after delay
  }

  void _navigateToHome() {
    Future.delayed(Duration(seconds: 2), () {

      //exit full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black));



      if (Apis.auth.currentUser != null) {   
      log('\nuser: ${Apis.auth.currentUser}');     //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
      } else {        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Replace this FlutterLogo widget with your custom logo
            Image.asset(
              'assets/icons8-chat-50.png', 
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'ChatPulse',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
