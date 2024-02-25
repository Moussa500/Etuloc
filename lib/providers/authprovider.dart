import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus {
  authenticating,
  authenticated,
  notauthenticating,
  error,
}

class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus authStatus = AuthStatus.notauthenticating;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void loginWithEmailandPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      if (user != null) {
        authStatus = AuthStatus.authenticated;
      } else {
        authStatus = AuthStatus.error;
      }
      print('Sign in successfully');
    } catch (e) {
      authStatus = AuthStatus.error;
      print('Error');
    }
    notifyListeners();
  }

  void registerWithEmailandPassword(String email, String password, String name,
      String phoneNumber, String status) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      if (user!=null) {
              await users.doc(user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phoneNumber,
        'status': status,
      });
         await user?.updateDisplayName(name);
         print('login Successfully');
      }
    } catch (e) {
      authStatus = AuthStatus.error;
      print('Error');
    }
    notifyListeners();
  }
}
