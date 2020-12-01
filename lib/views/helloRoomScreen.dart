import 'package:flutter/material.dart';
import 'package:hello/helper/authenticate.dart';
import 'package:hello/helper/constants.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/services/database.dart';
import 'package:hello/views/conversation_screen.dart';
import 'package:hello/views/search.dart';
import 'package:hello/widgets/widget.dart';

class HelloRoom extends StatefulWidget {
  @override
  _HelloRoomState createState() => _HelloRoomState();
}

class _HelloRoomState extends State<HelloRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream helloRoomsStream;

  Widget  helloRoomList(){
    return StreamBuilder(
      stream: helloRoomsStream,
      builder: (context,snapshot){

        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
            return HelloRoomTile(
             snapshot.data.documents[index].data["helloroomId"]
                 .toString().replaceAll("_", "")
                 .replaceAll(Constants.myname, ""),
                   snapshot.data.documents[index].data["helloroomId"]
            );
        }) : Container() ;
      },
    );
  }

  @override
  void initState() { 
    getUserInfo();
    super.initState();
  }
 
  getUserInfo()async{
    Constants.myname= await HelpersFunctions.getUserNameSharedPreference();
    databaseMethods.getHelloRooms(Constants.myname).then((value){
      setState(() {
        helloRoomsStream = value;
      });

    });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar  (
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
          ),
        ]
        ),
      body: helloRoomList(),

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
class HelloRoomTile extends StatelessWidget{
final String userName;
final String helloRoomId;
HelloRoomTile(this.userName,this.helloRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder:(context)=> ConversationScreen(helloRoomId)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
        child: Row(
          children:[
            Container(
              height: 40,
              width: 40,
              alignment:Alignment.center,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",
              style:mediumTextStyle(),),
            ),
            SizedBox(width:16),
            Text(userName,style:mediumTextStyle(),)

          ]
        ),
      ),
    );
  }
}

