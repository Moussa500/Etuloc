import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';
import '../services/sncak_bar_services.dart';
enum AuthStatus {
  authenticating,
  authenticated,
  notAuthenticating,
  error,
}
class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus authStatus = AuthStatus.notAuthenticating;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void loginWithEmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        SnackBarService.showErrorSnackBar(
            context, "Please fill in all the fields");
        return;
      }
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      authStatus = AuthStatus.authenticated;
      SnackBarService.showSuccessSnackBar(
          context, 'Welcome ${user!.displayName}');
      Navigator.pushNamed(context, "etudiant");
      print('Sign in successful');
    } catch (e) {
      authStatus = AuthStatus.error;
      String errorMessage = _handleAuthError(e)!;
      SnackBarService.showErrorSnackBar(context, errorMessage);
    }
    notifyListeners();
  }
  void registerWithEmailandPassword(String email, String password, String name,
      String phoneNumber, String status, BuildContext context) async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty || phoneNumber.isEmpty) {
        SnackBarService.showErrorSnackBar(
            context, "Please fill in all the fields");
        return;
      }
      if (!isEmail(email)) {
        SnackBarService.showErrorSnackBar(
            context, "Please Enter a valid Email address");
        return;
      }
      if (password.length < 6) {
        SnackBarService.showErrorSnackBar(context,
            "Please Enter a Strong Password with at least 6 characters");
        return;
      } else if (!isAlpha(name)) {
        SnackBarService.showErrorSnackBar(context, "Please Enter a valid name");
        return;
      } else if (phoneNumber.length < 6 || !isNumeric(phoneNumber)) {
        SnackBarService.showErrorSnackBar(
            context, "Please Enter a valid phone Number");
        return;
      }
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      authStatus = AuthStatus.authenticating;
      user = credential.user;
      authStatus = AuthStatus.authenticated;
      await users.doc(user!.uid).set({
        'name': name,
        'email': email,
        'phone': phoneNumber,
        'status': status,
      });
      await user?.updateDisplayName(name);
      authStatus = AuthStatus.authenticated;
      SnackBarService.showSuccessSnackBar(
          context, "Congratulations! Account created successfully");
      Navigator.pushNamed(context, "Etudiant");
    } catch (e) {
      authStatus = AuthStatus.error;
      String errorMessage = _handleAuthError(e)!;
      SnackBarService.showErrorSnackBar(context, errorMessage);
    }
    notifyListeners();
  }
  void resetPassword(String email, BuildContext context) async {
    try {
      if (email.isEmpty) {
        SnackBarService.showErrorSnackBar(
            context, "Please enter your email address");
        return;
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      SnackBarService.showSuccessSnackBar(
          context, 'Password reset email sent');
    } catch (e) {
      SnackBarService.showErrorSnackBar(context, e.toString());
    }
    notifyListeners();
  }
  String? _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'User not found. Please check your email and try again.';
        case 'wrong-password':
          return 'Invalid password. Please check your password and try again.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        default:
          return 'Please check your email and password then try again';
      }
    } 
  }
}
