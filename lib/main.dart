import 'package:flutter/material.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/views/helloRoomScreen.dart';
import 'helper/authenticate.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // 0xFFB2DFDB This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    bool userIsLoggedIn ;


  @override

  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelpersFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
        
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
       //     primaryColor:Color(0xFF4DB6AC).withOpacity(0.5),
        scaffoldBackgroundColor: Color(0xFF006064).withOpacity(0.6),
      //  backgroundColor: Colors.transparent,
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? HelloRoom():
      Authenticate(),
    );  
  }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
}

class IamBlank extends StatefulWidget {
  @override
  _IamBlankState createState() => _IamBlankState();
}

class _IamBlankState extends State<IamBlank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

