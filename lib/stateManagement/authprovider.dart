import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_federe/services/sncak_bar_services.dart';
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
  void loginWithEmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      authStatus = AuthStatus.authenticated;
      SnackBarService.showSuccessSnackBar(
          context, 'Welcome ${user!.displayName}');
      Navigator.pushNamed(context, "etudiant");
      print('Sign in successfully');
    } catch (e) {
      authStatus = AuthStatus.error;
      SnackBarService.showErrorSnackBar(context,e.toString());
    }
    notifyListeners();
  }
  void registerWithEmailandPassword(String email, String password, String name,
      String phoneNumber, String status, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      authStatus = AuthStatus.authenticated;
      await users.doc(user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phone': phoneNumber,
        'status': status,
      });
      await user?.updateDisplayName(name);
      authStatus = AuthStatus.authenticated;
      SnackBarService.showSuccessSnackBar(context, "Welcome ${user!.displayName}");
      Navigator.pushNamed(context, "Etudiant");
    } catch (e) {
      authStatus = AuthStatus.error;
      SnackBarService.showErrorSnackBar(context, e.toString());
      Navigator.pushNamed(context, "etudiant");
    }
    notifyListeners();
  }
}
