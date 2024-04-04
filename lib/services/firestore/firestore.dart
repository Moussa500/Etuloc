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
          "sum_ratings": 0,
          "phone_visibility": false,
          "city_visibility": false,
          "number_ratings": 0,
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

  //update infos
  Future<void> updateInfos(
      String collection, String docId, var newValue, String field) {
    return FirebaseFirestore.instance.collection(collection).doc(docId).update({
      field: newValue,
    });
  }
  //get the specific documents filtered by id
  Future<List<Map<String, dynamic>>> getSpecificDocuments(documentId,String collectionName) async {
    final collectionRef = _firestore.collection(collectionName);
  final querySnapshot = await collectionRef.where(FieldPath.documentId==documentId).get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

}
