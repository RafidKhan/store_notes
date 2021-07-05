import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/helper/shared_preferance.dart';
import 'package:notes_app/pages/home_page_screen.dart';
import 'package:notes_app/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));

    return Scaffold(
      key: globalScaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'Save Your Notes!',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      duration: const Duration(milliseconds: 5000),
                    ),
                  ],
                  // isRepeatingAnimation: true,
                  // totalRepeatCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
