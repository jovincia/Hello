import 'package:flutter/material.dart';
import 'package:hello/helper/constants.dart';
import 'package:hello/services/database.dart';
import 'package:hello/widgets/widget.dart';
 

class ConversationScreen extends StatefulWidget{
final String helloRoomId;
ConversationScreen(this.helloRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods =  new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();


  Widget HelloMessageList(){

  }
 sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,String>messageMap={
        "message": messageController.text,
        "sendBy" : Constants.myname,
      };
      databaseMethods.getConversationMessages(widget.helloRoomId,messageMap);
    }
    }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: appBarMain(context),
     body: Container(
       child: Stack(
         children:[
           Container(
             alignment: Alignment.bottomCenter,
             child: Container(
               //,
               width:MediaQuery.of(context).size.width,
               color: Color(0xFFE0F2F1) ,
               padding:EdgeInsets.symmetric(horizontal: 24,vertical: 16),
               child:Row(
                 children: [
                   Expanded(

                     child: TextField(
                       controller: messageController,
                       style:TextStyle(
                           color:Colors.black
                       ),
                       decoration: InputDecoration(
                           hintText: "Message...",
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
                       //initiateSearchEmail();
                      // initiateSearchUserName();

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
                         child: Image.asset("assets/images/send.png")),
                   )
                 ],
               ),
             ),
           )

         ]
       ),
     ),
   );

  
  }
}

