import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/helper/constants.dart';
import 'package:hello/helper/helperfunctions.dart';
import 'package:hello/services/database.dart';
import 'package:hello/widgets/widget.dart';
import 'conversation_screen.dart';

 class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
  String _myName ;
class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(

      itemCount: searchSnapshot.documents.length ,
       shrinkWrap:true,
      itemBuilder: (context, index){
        return SearchTile(
          userName:searchSnapshot.documents[index].data["name"],
          userEmail:searchSnapshot.documents[index].data["email"],
        );
    }) : Container();
  }


  initiateSearchUserName(){
    databaseMethods.getUserByUsername
      (searchTextEditingController.text)
        .then((val){
          setState(() {
    searchSnapshot=val;

    });
    });
  }

  initiateSearchEmail(){
    databaseMethods.getUserByUseremail
      (searchTextEditingController.text)
        .then((val){
      setState(() {
        searchSnapshot=val;

      });
    });

  }
// controller for chatroom and conversation

 createChatRoomAndStartConversation({ String userName,}){
    print("${Constants.myname}");
   if(userName != Constants.myname){
     String helloRoomId = getHelloRoomId(userName,Constants.myname);
    List<String> users =[userName, Constants.myname ];
    Map <String,dynamic> helloRoomMap={
      "users":users,
      "helloroomId" :helloRoomId,
    };
    DatabaseMethods().createHelloRoom(helloRoomId, helloRoomMap);
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> ConversationScreen(
          helloRoomId
        ),
      ));
   }
   else {
     print("You can't send message to yourself ");
   }
  }
  Widget SearchTile({String userName, String userEmail}){
   
    return Container(
      width:MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style:TextStyle(
                color:Colors.white,
                fontSize: 16,
              )),
              Text(userEmail,style: TextStyle(
                color:Colors.white,
                fontSize: 16,
              )),
            ],
          ),
          Spacer(),

          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(
                userName: userName

              );

            },
            child: Container(
              //width : MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal:16,vertical:12),
              decoration:BoxDecoration(
                color:Colors.teal,
                borderRadius:BorderRadius.circular(24)

              ),
              child:Text("Message",style:TextStyle(
                color:Colors.white,
                fontSize:16,
              ),),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
   // getUserInfo();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          width:MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              //,
              width:MediaQuery.of(context).size.width,
              color: Color(0xFFE0F2F1) ,
              padding:EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child:Row(
                children: [
                  Expanded(

                child: TextField(
                  controller: searchTextEditingController,
                style:TextStyle(
                    color:Colors.black
                ),
                decoration: InputDecoration(
                  hintText: "search username...",
                  hintStyle:TextStyle(
                      color:Colors.black,
                  ),
                  border:InputBorder.none
                ),
              ),
            ),
            /* GestureDetector(
               onTap: (){
                 initiateSearchEmail();
               },

             ),*/
             GestureDetector(
               onTap: (){
                 initiateSearchEmail();
                 initiateSearchUserName();

                 },
               child: Container(
                  // width:MediaQuery.of(context).size.width,
                   height:40,
                  // width:40,
               decoration: BoxDecoration(
                 gradient:LinearGradient(

                     colors:[
                       const Color(0xFFFFFFFF),
                        const Color(0xFFFFFFFF),

                    // const Color(0xFFE0F2F1),
                    //const Color(0xFFE0F7FA),
                   ]
                 ),
                     borderRadius:BorderRadius.circular(40)
               ),
               padding: EdgeInsets.all(12),
               child: Image.asset("assets/images/index.png")),
             )
          ],
        ),
      ),
            searchList(),
      ]
      )
      )
    );
  }
 




getHelloRoomId(String i, String l){
  if(i.substring(0,1).codeUnitAt(0) > l.substring(0,1).codeUnitAt(0)){
    return "$l\_$i";
  }
  else{
    return "$i\_$l";
  }
}
}