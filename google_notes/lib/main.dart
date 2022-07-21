import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_notes/login.dart';
import 'package:google_notes/screens/home.dart';
import 'package:google_notes/services/logininfo.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
 @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  bool isLogIn = false;
  getLoggedInState() async{
    
  await LocalDataSaver.getLogData().then((value){
 
      setState(() {
          isLogIn = value.toString() == "null";
      });
    });
  }

  @override
  void initState() {
    
    super.initState();
        getLoggedInState();

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: isLogIn ?  Home() : Login(),
    );
  }
}



