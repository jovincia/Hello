import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/services/database.dart';
import 'package:hello/views/forgotpassword.dart';
import 'package:hello/widgets/widget.dart';
import 'helloRoomScreen.dart';

class Signin extends StatefulWidget{
    final Function toggle;
    Signin(this.toggle);

 @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State <Signin>{
  final formKey = GlobalKey <FormState>();
  AuthMethods authMethods = new AuthMethods();
TextEditingController emailTextEditingController = new TextEditingController();
DatabaseMethods databaseMethods = new DatabaseMethods();
TextEditingController passwordTextEditingController = new TextEditingController();
bool isLoading= false;
QuerySnapshot snapshotUserInfo;

signMeIn(){
  if(formKey.currentState.validate()){

      HelpersFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      databaseMethods.getUserByUseremail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelpersFunctions.
        saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
       // print("${snapshotUserInfo.documents[0].data["name"]} this isn't good");
      });
      
// TODO function o get  userdetails
    setState(() {
      isLoading= true;
    });

    authMethods.signInWithEmailAndPassword(
      emailTextEditingController.text,
       passwordTextEditingController.text).then((val){
       if(val != null){
         HelpersFunctions.saveUserLoggedInSharedPreference(true);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> HelloRoom(),
      ));

       }

       });
    
  }

}
  
  @override
  Widget build(BuildContext context){ 
    return Scaffold(
       body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
          alignment: Alignment.center,
          child:Container(
          padding: EdgeInsets.symmetric(horizontal:24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children:[
                          TextFormField(
                            validator: (val){
                          return RegExp(
                            r"^[a-zA-z0-9.a-zA-z0-9.!#$%&'*-+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val) ? null: "Enter a valid email";
                        },
                    controller: emailTextEditingController,
                    style: simpleTextStyle(),
                    decoration:textFieldInputDecoration("Email"),
                    ),
                  TextFormField(
                     obscureText:true,
                        validator: (val){
                      /* if (val != passwordTextEditingController ){
                         return "Your password isn't conform";
                       }*/

                          return val.length > 8 ? null:"Please provide password with 8+ characters";
                        },
                    controller: passwordTextEditingController,
                     style: simpleTextStyle(),
                    decoration:textFieldInputDecoration("Password"),
                  ),
                     ] ),
                ),
                SizedBox(height:8),
                Container(
                  alignment:Alignment.centerRight,
                  child:Container(
                    width:double.infinity,
                    padding:EdgeInsets.symmetric(horizontal:16,vertical:8),
                    child:InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext )=>Forgotpassword()));
                      },
                      child:Text("Password Forgot?", style:simpleTextStyle() ,),
                ),
                  ),
                ),
                SizedBox(height:8),
                GestureDetector(
                  onTap:(){
                    signMeIn();
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
                    child: Text("Sign in",style:mediumTextStyle()
                    ),
                  ),
                ),
                 SizedBox(height:16),
                Container(
                  alignment:Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding:EdgeInsets.symmetric(vertical: 20),
                  decoration:  BoxDecoration(
                      color:Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(30)
                        //const Color(0xDAF7A6),
                      ),
                  child: Text("Sign in with google",style:TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                  ),
                  ),

                  ),
                SizedBox(height:16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Don't have account?",style:TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(" Signup now",style:TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline

                         ),),
                      ),
                    ),
                  ]
                ),
                SizedBox(height:50),
              ],
            ),
          ),
    ),
      ),
    );
  }
}