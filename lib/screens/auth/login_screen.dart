import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

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
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },

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
