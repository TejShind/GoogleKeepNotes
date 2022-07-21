import 'package:flutter/material.dart';
import 'package:google_notes/colors.dart';
import 'package:google_notes/services/db.dart';

import '../model/notemodel.dart';
import 'NoteView.dart';

// ignore: must_be_immutable
class EditViewNote extends StatefulWidget {
  Note note;
  EditViewNote({required this.note});
  @override
  State<EditViewNote> createState() => _EditViewNoteState();
}

class _EditViewNoteState extends State<EditViewNote> {
  late String NewTitle;
  late String NewNoteDetails;
  @override
  void initState() {
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDetails = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                Note newNote = Note(
                    content: NewNoteDetails,
                    title: NewTitle,
                    createdTime: widget.note.createdTime,
                    isArchive: widget.note.isArchive,
                    pin: widget.note.pin,
                    id: widget.note.id);
                await NotesDatabse.instance.updateNote(newNote);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteView(
                              note: newNote,
                            )));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Form(
                child: TextFormField(
              initialValue: NewTitle,
              cursorColor: white,
              onChanged: (value) {
                NewTitle = value;
              },
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8))),
            )),
            Container(
              height: 300,
              child: Form(
                  child: TextFormField(
                onChanged: (value) {
                  NewNoteDetails = value;
                },
                initialValue: NewNoteDetails,
                cursorColor: white,
                keyboardType: TextInputType.multiline,
                minLines: 50,
                maxLines: null,
                style: TextStyle(fontSize: 17, color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8))),
              )),
            )
          ],
        ),
      ),
    );
  }
}
