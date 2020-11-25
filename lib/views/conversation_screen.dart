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
  Stream helloMessageStream;


  Widget HelloMessageList(){
    return StreamBuilder(
      stream: helloMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data["message"],
                snapshot.data.documents[index].data["sendBy"]== Constants.myname);
          }):Container();


      },
    );

  }
 sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic>messageMap={
        "message": messageController.text,
        "sendBy" : Constants.myname,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.helloRoomId,messageMap);
      messageController.text = "";
    }
    }
    @override
  void initState() {
   databaseMethods.getConversationMessages(widget.helloRoomId).then((value){
     setState(() {
       helloMessageStream = value;
     });
   });
    super.initState();
  }

   


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: appBarMain(context),
     body: Container(
       child: Stack(
         children:[
           HelloMessageList(),
           Container(
             alignment: Alignment.bottomCenter,
             child: Container(
               width:MediaQuery.of(context).size.width,
               color: Color(0xFFE0F2F1) ,
               //reverse: true,
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
                      sendMessage();

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
         ],
       ),
     ),
   );

  
  }
}

class MessageTile extends StatelessWidget {
  final String message;
   final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(left:  isSendByMe ? 0: 24 ,right: isSendByMe ? 24:0),
      margin:EdgeInsets.symmetric(vertical:8),
      width:MediaQuery.of(context).size.width,
      alignment:isSendByMe ? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration:BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xFF004D40),
              const Color(0xFFB2EBF2),
            ]
                :
            [
              const Color(0xFF37474F),
              const Color(0xFF263238),

            ],
          ),
            borderRadius: isSendByMe ?
                BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                ):
            BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
               ),
        ),
         child:Text(message,style:simpleTextStyle()),
    ),
    );
  }
}


