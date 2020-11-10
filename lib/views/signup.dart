import'package:flutter/material.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/services/database.dart';
import 'package:hello/widgets/widget.dart';
import 'helloRoomScreen.dart';

class Signup extends StatefulWidget {
  final Function toggle;
  Signup(this.toggle);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isLoading=false;
  AuthMethods authMethods =new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelpersFunctions helpersFunctions=new HelpersFunctions();


  final formKey = GlobalKey <FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  TextEditingController confirmpasswordTextEditingController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){

      Map<String,String> userInfoMap= {
        "name": userNameTextEditingController.text,
        "email" : emailTextEditingController.text
      };

      HelpersFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelpersFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

    setState(() {
      isLoading=true;
    });

    authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
        passwordTextEditingController.text).then((val){
      //print("${val.uid}");



      databaseMethods.uploadUserInfo(userInfoMap );
      HelpersFunctions.saveUserLoggedInSharedPreference(true);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> HelloRoom(),
      ));

    });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarMain (context),
      body: isLoading ? Container (
        child:Center(child: CircularProgressIndicator())
      ):SingleChildScrollView(
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
                    children: [
                      TextFormField(
                        validator: (val){
                          return val.isEmpty || val.length < 2 ? "Enter your username":null;
                        },
                      controller: userNameTextEditingController,
                      style: simpleTextStyle(),
                      decoration:textFieldInputDecoration("Username"),
                    ),

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
                          if (val.isEmpty){
                            return "This field is empty" ;
                            return null;
                          }
                          return val.length > 8 ? null:"Please provide password with 8+ characters";
                        },
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration:textFieldInputDecoration("Password"),
                      ),

                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          if (val.isEmpty){
                            return "This field is empty";
                            return null;
                          }
                          if(val !=passwordTextEditingController.text){
                            return "This password isn't conform";
                            return null;
                          }
                          return val.length > 8 ? null:"Please provide password with 8+ characters";
                        },
                        controller: confirmpasswordTextEditingController,
                        style: simpleTextStyle(),
                        decoration:textFieldInputDecoration(" Confirm Password"),
                      ),],
                  ),
                ),

                SizedBox(height:8),
               /* Container(
                  alignment:Alignment.centerRight,
                  child:Container(
                    padding:EdgeInsets.symmetric(horizontal:16,vertical:8),
                    child: Text("Password Forgot?", style:simpleTextFieldStyle() ,),
                  ),
                ),*/
                SizedBox(height:16),
                GestureDetector(
                  onTap:(){
                    signMeUp();
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
                    child: Text("Sign up",style:mediumTextStyle()
                    ),
                  ),
                ),
                SizedBox(height:16),
               /* Container(
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

                SizedBox(height:16),*/
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Already have account?",style:TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical:8),
                          child: Text(" Sign in",style:TextStyle(
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




