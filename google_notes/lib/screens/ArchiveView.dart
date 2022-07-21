import 'package:flutter/material.dart';
import 'CreateNoteView.dart';
import 'package:google_notes/screens/SideMenuBar.dart';
import 'package:google_notes/colors.dart';
class ArchiveView extends StatefulWidget {
  const ArchiveView({Key? key}) : super(key: key);

  @override
  _ArchiveViewState createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  String note1 = "THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreateNoteView()) );
        },
        backgroundColor: cardColor,
        child: Icon(Icons.add , size: 45,),
      ),
        endDrawerEnableOpenDragGesture: true,
        key: _drawerKey,
        drawer: SideMenu(),
        backgroundColor: bgColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3)
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              Container(
                                  height: 55,
                                  width: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Search Your Notes",
                                          style: TextStyle(
                                              color: white.withOpacity(0.5),
                                              fontSize: 16),
                                        )
                                      ]))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    white.withOpacity(0.1)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ))),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.grid_view,
                                      color: white,
                                    )),
                                SizedBox(
                                  width: 9,
                                ),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ])),
                NoteSectionAll(),
              ],
            ),
          ),
        )));
  }

  Widget NoteSectionAll() {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ALL",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => NoteView()));
                      // },
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
                              "HEADING",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              index.isEven
                                  ? note.length > 250
                                      ? "${note.substring(0, 250)}..."
                                      : note
                                  : note1,
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

// class ArchiveView extends StatefulWidget {
//   const ArchiveView({Key? key}) : super(key: key);

//   @override
//   _ArchiveViewState createState() => _ArchiveViewState();
// }

// class _ArchiveViewState extends State<ArchiveView> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//   String note =
//       " ITS MY NOTE !ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ITS MY NOTE ! ";
//   String note1 =
//       " THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE  THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE    NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE  THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE  ";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => CreateNoteView()));
//           },
//           backgroundColor: cardColor,
//           child: Icon(
//             Icons.add,
//             size: 45,
//           ),
//         ),
//         endDrawerEnableOpenDragGesture: true,
//         key: _drawerKey,
//         drawer: SideMenu(),
//         backgroundColor: white,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: [
//                 Container(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     width: MediaQuery.of(context).size.width,
//                     height: 55,
//                     decoration: BoxDecoration(
//                         color: cardColor,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey,
//                               spreadRadius: 1,
//                               blurRadius: 5)
//                         ]),
//                     child: Row(children: [
//                       Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 _drawerKey.currentState!.openDrawer();
//                               },
//                               icon: Icon(
//                                 Icons.menu,
//                                 color: white,
//                               )),
//                           SizedBox(
//                             width: 16,
//                           ),
//                           GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => SearchView()));
//                               },
//                               child: Container(
//                                   height: 55,
//                                   width: 200,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Search your Notes",
//                                         style: TextStyle(
//                                             color: white.withOpacity(0.5),
//                                             fontSize: 15),
//                                       ),
//                                     ],
//                                   )))
//                         ],
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 2),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextButton(
//                                 onPressed: () {},
//                                 child: Icon(
//                                   Icons.grid_view,
//                                   color: white,
//                                 )),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             CircleAvatar(
//                               radius: 16,
//                               backgroundColor: Colors.white,
//                             )
//                           ],
//                         ),
//                       ),
//                     ])),
//                 NoteSectionAll(),

//                 //     //Colored Notes
//                 // Container(
//                 //     height: MediaQuery.of(context).size.height,
//                 //     child: ListView.builder(
//                 //       physics: NeverScrollableScrollPhysics(),
//                 //       shrinkWrap: true,
//                 //       itemCount: 15,
//                 //       itemBuilder: (context, position) {
//                 //         return Container(
//                 //           padding: EdgeInsets.all(10),
//                 //           decoration: BoxDecoration(
//                 //               color: Color.fromARGB(255, 228, 188, 188),
//                 //               border: Border.all(color: black.withOpacity(0.4)),
//                 //               borderRadius: BorderRadius.circular(7)),
//                 //           child: Column(
//                 //             crossAxisAlignment: CrossAxisAlignment.start,
//                 //             children: [
//                 //               Text(
//                 //                 "HEADING",
//                 //                 style: TextStyle(
//                 //                     color: black,
//                 //                     fontSize: 25,
//                 //                     fontWeight: FontWeight.bold),
//                 //               ),
//                 //               SizedBox(height: 7),
//                 //               Text(note, style: TextStyle(color: black))
//                 //             ],
//                 //           ),
//                 //         );
//                 //       },
//                 //     ))
//               ],
//             ),
//           ),
//         )));
//   }

//   Widget NoteSectionAll() {
//     return Container(
//         child: Column(
//       children: [
//         Container(
//             decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   " ALL ",
//                   style: TextStyle(
//                       color: black.withOpacity(0.5),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             )),
//         Container(
//             height: MediaQuery.of(context).size.height,
//             child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 15,
//                 itemBuilder: (context, index) => InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => NoteView()));
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: black.withOpacity(0.4)),
//                             borderRadius: BorderRadius.circular(7)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "HEADING",
//                               style: TextStyle(
//                                   color: black,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               index.isEven
//                                   ? note.length > 250
//                                       ? "${note.substring(0, 250)}..."
//                                       : note
//                                   : note1,
//                               style: TextStyle(color: black),
//                             )
//                           ],
//                         ),
//                       ),
//                     ))),
//       ],
//     ));
//   }
// }
