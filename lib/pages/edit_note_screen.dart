import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/home_page_screen.dart';

class EditNoteScreen extends StatefulWidget {
  //EditNoteScreen({this.fetchTitle,this.fetchNote});

  final Map data;
  final String time;
  final DocumentReference ref;

  EditNoteScreen(this.data, this.time, this.ref);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  String title;
  String note;

  DateTime dateTimeUpdate = DateTime.now();
  //DateFormat.yMMMd().add_jm().format(dateTimeUpdate);

  void deleteNote() async {
    //Delete from Database
    await widget.ref.delete();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePageScreen()));
  }
  void updateNote() async {

    widget.ref.update({'title': title, 'note': note});

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePageScreen()));
  }

  @override
  void initState() {
    setState(() {
      titleController.text = widget.data['title'].toString();
      noteController.text = widget.data['note'].toString();

      note= noteController.text;
      title= titleController.text;
    });
    super.initState();
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            deleteNote();
                          },
                          child: Icon(Icons.delete),
                        ),
                        SizedBox(width: 10.0,),
                        ElevatedButton(
                          onPressed: () {
                            updateNote();
                          },
                          child: Icon(Icons.done),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(widget.time),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: titleController,
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
                      controller: noteController,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
