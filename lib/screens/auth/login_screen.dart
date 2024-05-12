import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key); // Corrected the constructor

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        title: Text('This is Chat App'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            left: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/talking.png')),
            
      Positioned(
  bottom: mq.height * 0.15,
  left: mq.width * 0.05,
  width: mq.width * 0.9,
  height: mq.height * 0.07,
  child: ElevatedButton.icon(
    onPressed: () {},
    icon: SvgPicture.asset(
      'assets/sign.svg', height: mq. * .03
      //width: 28,
      //height: 28,
    ),
    label: Text(
      'Sign in with Google',
      style: TextStyle(color: Colors.white), // Set text color to white
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Set button color to black
    ),
  ),
),


        ],
      ) 
    );
  }
}
