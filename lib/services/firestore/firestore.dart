//add user info
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  //get all the documents from a collection
  Stream<List<Map<String, dynamic>>> getCollectionStream(
      String collectionName) {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
  Stream<QuerySnapshot> getHousedStream() {
    final notesStream =
        _firestore.collection("houses").snapshots();
    return notesStream;
  }
  //post a house
  Future<void> postHouse(
      String city,
      String price,
      String url,
      String availablePlaces,
      String location,
      bool bed,
      String type,
      String places,
      String uid,
      String gender) async {
    await _firestore.collection("houses").doc().set({
      "price": price,
      "images_url": url,
      "city_name": city,
      "uid": uid,
      "available_places": places,
      "gender": gender,
      "location": location,
      "bed": bed,
      "house": !bed,
      "state": "available",
      "type": type,
      "places": places,
    });
  }

  Future<void> deleteHouse(String uid) async{
    return await _firestore
        .collection("houses")
        .doc(uid).delete();
  }
}
