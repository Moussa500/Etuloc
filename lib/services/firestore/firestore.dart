//add user info
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //add user's info to separate document after logging in
  Future saveUsersInfo(String email, name, phone, status, uid) async {
    try {
      await _firestore.collection('user').doc(uid).set({
        "uid": uid,
        "email": email,
        "name": name,
        "phone": phone,
        "status": status,
      });
      if (status == "landlord") {
        await _firestore.collection("landlordsProfile").doc(uid).set({
          "uid": uid,
          "phone_number": phone,
          "name": name,
          "rate": 0,
          "posted_houses": 0,
          "rented_houses": 0,
          "city": "",
          "pdp": "",
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }
  //get infos from the firebase
  Future<dynamic> getValueFromFirestore(DocumentReference docRef) async {
    DocumentSnapshot snapshot = await docRef.get();
    if (snapshot.exists) {
      return snapshot.data(); 
    } else {
      return null; 
    }
  }
}
