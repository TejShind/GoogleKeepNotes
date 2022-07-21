import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_notes/login.dart';
import 'package:google_notes/screens/NoteView.dart';
import 'package:google_notes/screens/SearchPage.dart';
import 'package:google_notes/services/auth.dart';
import 'package:google_notes/services/db.dart';
import 'package:google_notes/services/firestore_db.dart';
import '../model/notemodel.dart';
import '../services/logininfo.dart';
import 'CreateNoteView.dart';
import 'package:google_notes/screens/SideMenuBar.dart';
import 'package:google_notes/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoding = true;
  late String? ImgUrl;
  List<Note> noteList = [];
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    

    getNotes();
  }

  Future createData(Note note) async {
    await NotesDatabse.instance.InsertData(note);
  }

  Future getNotes() async {
    // log(noteList.length.toString());
    LocalDataSaver.getImg().then((value) {
      if (this.mounted) {
        setState(() {
          ImgUrl = value;
        });
      }
    });
    this.noteList = await NotesDatabse.instance.readAllNotes();
    //log(noteList.length.toString());
    if (this.mounted) {
      setState(() {
        isLoding = false;
      });
    }
  }

  Future getOneNotes(int id) async {
    await NotesDatabse.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabse.instance.updateNote(note);
  }

  Future deleteNote(Note note) async {
    await NotesDatabse.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoding
        ? Scaffold(
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: Icon(
                Icons.add,
                size: 45,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: SideMenu(),
            backgroundColor: white,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ]),
                        child: Row(children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _drawerKey.currentState!.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: white,
                                  )),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchView()));
                                  },
                                  child: Container(
                                      height: 55,
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Search your Notes",
                                            style: TextStyle(
                                                color: white.withOpacity(0.5),
                                                fontSize: 15),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.grid_view,
                                      color: white,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    signOut();
                                    LocalDataSaver.saveLoginData(false);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: CircleAvatar(
                                    onBackgroundImageError:
                                        (Object, StackTrace) {
                                      log("OK");
                                    },
                                    radius: 16,
                                    backgroundImage:
                                        NetworkImage(ImgUrl.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    NoteSectionAll(),
                  ],
                ),
              ),
            )),
          );
  }

  Widget NoteSectionAll() {
    return Container(
        child: Column(
      children: [
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " ALL ",
                  style: TextStyle(
                      color: black, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: noteList.length,
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NoteView(note: noteList[index])));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: black.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noteList[index].title,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              noteList[index].content.length > 100
                                  ? "${noteList[index].content..substring(0, 100)}..."
                                  : noteList[index].content,
                              style: TextStyle(color: black),
                            )
                          ],
                        ),
                      ),
                    ))),
      ],
    ));
  }
}
