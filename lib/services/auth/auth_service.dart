import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_federe/services/firestore/firestore.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FireStoreService _fireStoreService = FireStoreService();
  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign up
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, name, phone, status) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      //add the fields to a separate folder
       await _fireStoreService.saveUsersInfo(email, name, phone, status,userCredential.user!.uid);
      User user = userCredential.user!;
      //save the name and the phone number of the user
      user.updateDisplayName(name);
      user.updatePhoneNumber(phone);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //reset password
  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
  //errors
}
