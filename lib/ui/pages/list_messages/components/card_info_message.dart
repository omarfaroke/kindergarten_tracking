import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:food_preservation/models/message.dart';

class CardInfoMessage extends StatelessWidget {
  const CardInfoMessage({
    Key key,
    this.message,
    this.fromMe = false,
  }) : super(key: key);

  final MessageModel message;
  final bool fromMe;
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: const BubbleEdges.only(top: 5 ,bottom : 5),
      alignment: fromMe ? Alignment.topRight : Alignment.topLeft,
      nip: fromMe ? BubbleNip.rightTop : BubbleNip.leftTop,
      child: Text(message.message , style: TextStyle(
        fontSize: 16,
      )),
    );
  }
}
