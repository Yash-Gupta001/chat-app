import 'package:chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



//global object for accessing device screen size
late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
  //FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
            appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),
          backgroundColor: Colors.black,
        )
        ),
      home: SplashScreen(),
    );
  }
}


_initializeFirebase() async {
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
}

