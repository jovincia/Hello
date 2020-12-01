import 'package:flutter/material.dart';
import 'package:hello/widgets/widget.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final String translatedMessage;
  final bool isSendByMe;

  MessageWidget(this.message,this.translatedMessage,this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children:<Widget> [
        Container(
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
child: buildMessage(),

  ),
      ),
    ],

  );
}
Widget buildMessage()=> Column(
  crossAxisAlignment:
    isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  children:<Widget> [
    Text(
      message,
      style: TextStyle(
        color:isSendByMe ? Colors.black : Colors.white,
        fontSize:14,
      ),
      textAlign: isSendByMe ? TextAlign.end : TextAlign.start,
    ),
    Text(
      translatedMessage,
      style: TextStyle(
        color: isSendByMe ? Colors.black : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      textAlign: isSendByMe ? TextAlign.end : TextAlign.start,
    ),
  ],
);
}

