import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/home_page_screen.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String title;
  String note;

  void saveNote() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Notes");

    var noteDate = {
      'title': title,
      'note': note,
      'created on': DateTime.now(),
    };

    ref.add(noteDate);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePageScreen()));
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveNote();
                      },
                      child: Icon(Icons.done),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Title",
                          hintStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          )),
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write Your Note!",
                            hintStyle: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            )),
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                        ),
                        onChanged: (value) {
                          note = value;
                        },
                        maxLines: 50,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
