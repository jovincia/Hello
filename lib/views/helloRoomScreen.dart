import 'package:flutter/material.dart';
import 'package:hello/helper/authenticate.dart';
import 'package:hello/helper/constants.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/views/search.dart';
import 'package:hello/views/signin.dart';

class HelloRoom extends StatefulWidget {
  @override
  _HelloRoomState createState() => _HelloRoomState();
}

class _HelloRoomState extends State<HelloRoom> {
  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() { 
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myname= await HelpersFunctions.getUserNameSharedPreference();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text("Hello",),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signout();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Authenticate(),
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:Icon(Icons.exit_to_app)
            ),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=> SearchScreen()
        ));
        },
      )
    );
  }
}
