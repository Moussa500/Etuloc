import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_federe/components/message.dart';

class ChatService {
  //get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
      senderID: currentUserId,
      receiverID: receiverID,
      message: message,
      timestamp: Timestamp.now(),
    );
    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverID];
    ids.sort(); //sort the ids(this ensure the chatroomID is the same for any 2 people)
    String chatroomID = ids.join('_');
    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomID)
        .collection("message")
        .add(newMessage.toMap());
  }
  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
