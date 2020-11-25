import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: 
    Text("Hello",),
  );
}
Widget appBarPassForgot(BuildContext context){
  return AppBar(
    title:
    Text("Password Forgot",),
    backgroundColor: Colors.white,


  );
}
//white54
InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
  hintText: hintText,
  hintStyle: TextStyle(
    color: Colors.white54,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white)
   ),
   enabledBorder: UnderlineInputBorder(
     borderSide: BorderSide(color:Colors.white)
   )
  );

}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
    );
}

TextStyle mediumTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
    );
}

TextStyle passTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 20,
  );
}


