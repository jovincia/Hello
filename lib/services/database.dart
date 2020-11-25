import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async{
   return await Firestore.instance.collection("users").
        where ('name',isEqualTo: username)
    .getDocuments();

  }
  
  getUserByUseremail(String useremail) async{
   return await Firestore.instance.collection("users").
        where ('email',isEqualTo: useremail)
    .getDocuments();

  }


  uploadUserInfo(userMap){
    Firestore.instance.collection("users").
    add(userMap).catchError((e){
      print(e.toString());

    });
  }
  createHelloRoom( String helloroomId, helloRoomMap){
    Firestore.instance.collection("HelloRoom")
        .document(helloroomId).setData(helloRoomMap).catchError((e)
        {
      print(e.toString());

    });

  }

  addConversationMessages(String helloRoomId , messageMap){
  Firestore.instance.collection("HelloRoom")
      .document(helloRoomId)
      .collection("hellos")
      .add(messageMap).catchError((e){
        print(e.toString());
     });
  }
  getConversationMessages(String helloRoomId)async{
     return await Firestore.instance.collection("HelloRoom")
        .document(helloRoomId)
        .collection("hellos")
         .orderBy("time",descending: false)
        .snapshots();

  }
  getHelloRooms(String userName)async{
    return await Firestore.instance
        .collection("HelloRoom")
        .where("users",arrayContains: userName)
        .snapshots();
  }

}