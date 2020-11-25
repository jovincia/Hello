import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/widgets/widget.dart';


class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  String email= "";
  var _formKey= GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPassForgot(context),
      backgroundColor: Colors.teal,
      body: Center(
        child: Padding(padding: EdgeInsets.only(top:200,left: 25,right: 25),

            child:Form(
      key: _formKey  ,
      child:Column(
              children: <Widget>[
                Text("We will share you a link ... Please click on that to reset your password",
            style: passTextStyle(),
            ),


    Form(
   child:Column(
      children:[
        Padding(padding: EdgeInsets.only(top: 30),),
    TextFormField(
      validator: (val){
    return RegExp(
    r"^[a-zA-z0-9.a-zA-z0-9.!#$%&'*-+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val) ? null: "Enter a valid email";
    },
   // controller: emailTextEditingController,
    style: simpleTextStyle(),
    decoration:textFieldInputDecoration("Email"),
    ),
          ],
      ),
      ),
                Padding(padding: EdgeInsets.only(top: 30,right: 20,left: 20),),
                GestureDetector(
                  onTap:(){
                    if (_formKey.currentState.validate()){
                      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then ((value)=>print("Check your email"));
                    }

                  },
                  child: Container(
                    alignment:Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding:EdgeInsets.symmetric(vertical: 20),
                    decoration:  BoxDecoration(
                        color: Colors.teal.withOpacity(1),
                        //color: Color(0x00000000).withOpacity(0),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Send email ",style:mediumTextStyle()
                    ),
                  ),
                ),
      ],
    ),
    ),
      ),
    ),
    );
  }
}
