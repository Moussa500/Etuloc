import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_federe/components/chat_bubble.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/textfields.dart';
import 'package:projet_federe/services/auth/auth_service.dart';
import 'package:projet_federe/services/chat_service/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverID;
  final String receiverName;
  final String receiverPDP;
  ChatPage(
      {super.key,
      required this.receiverID,
      required this.receiverName,
      required this.receiverPDP});
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  void sendMessage() async {
    //if there is something inside the TextField
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageController.text);
      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(foregroundImage: NetworkImage(receiverPDP)),
            const SizedBox(
              width: 10,
            ),
            Text(
              receiverName,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display all the messages
          Expanded(child: _buildMessageList()),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          //return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => SizedBox(
                  child: _buildMessageItem(doc)))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //align message to the right if sender is the current user , otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return ChatBubble(message: data["message"], isCurrentUser: isCurrentUser);
  }

  //build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        //textfield should take up most of the space
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomTextField(
              label: "Type a message", controller: _messageController),
        )),
        //send button
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: myPrimaryColor,
          ),
          child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward,color: Colors.white,)))
      ],
    );
  }
}
