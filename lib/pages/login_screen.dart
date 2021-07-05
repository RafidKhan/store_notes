import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/authentications/google_authentication.dart';
import 'package:notes_app/helper/shared_preferance.dart';
import 'package:notes_app/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool status = false;
  HelperFunctions helperFunctions = new HelperFunctions();

  final formKey = GlobalKey<FormState>();

  loginWithGoogleMethod() {
    try {
      loginInWithGoogle(context);
      HelperFunctions.saveUserLoggedInSharedPreference(status);
      setState(() {
        status = true;
      });
    } catch (e) {
      print(e.toString() + "************LOG IN FAOLED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 200.0, 20.0, 0.0),
            child: Column(
              children: [
                Image.asset('assets/notebook.png'),
                SizedBox(height: 50.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Container(
                        color: Colors.lightBlueAccent[100],
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/google.png'),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Sign In With Google',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent[100],
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          onPressed: () {
                            loginWithGoogleMethod();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
