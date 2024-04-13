import 'package:flutter/material.dart';
import 'package:projet_federe/components/colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key,required this.message,required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCurrentUser?myPrimaryColor:Colors.grey.shade500,
      padding: const EdgeInsets.all(8),
      child: IntrinsicWidth(child: Text(message,style: TextStyle(color: Colors.white,fontSize: 25),)),
    );
  }
}
