import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/helper/shared_preferance.dart';
import 'package:notes_app/pages/add_note_screen.dart';
import 'package:notes_app/pages/edit_note_screen.dart';
import 'package:notes_app/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool status = false;
  HelperFunctions helperFunctions = new HelperFunctions();

  //AccesingNotes
  CollectionReference ref = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("Notes");

  saveLoggedInState() {
    HelperFunctions.saveUserLoggedInSharedPreference(status);
    setState(() {
      status = false;
    });
  }

  Future signOut() {
    try {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen()));
      saveLoggedInState();

      return auth.signOut();
    } catch (e) {
      setState(() {
        status = true;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    saveLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AddNoteScreen()));
            },
            icon: Icon(Icons.note_add)),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(40.0, 40.0, 0.0, 0.0),
                child: Text(
                  'Save Your Notes!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(fontSize: 18.0, fontFamily: 'OverpassRegular'),
              ),
              onTap: () {
                signOut();
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(), //FetchingAccesedNote
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map data = snapshot.data.docs[index].data();
                  DateTime dateTime = (data['created on']).toDate();
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                              data,
                              DateFormat.yMMMd().add_jm().format(dateTime),
                              snapshot.data.docs[index].reference),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      margin: EdgeInsets.all(10.0),
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${data['title']}",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 80.0,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                DateFormat.yMMMd().add_jm().format(dateTime),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
