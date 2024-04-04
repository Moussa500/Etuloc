import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/pages/Etudiant/homepage.dart';
import 'package:projet_federe/pages/landlord/home_page.dart';
import 'package:projet_federe/services/auth/login_or_signup.dart';
import 'package:projet_federe/services/firestore/firestore.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  //get the status of the user from the firestore
  String? status;
  final FireStoreService _fireStoreService = FireStoreService();
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: _fireStoreService.getValueFromFirestore(
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(FirebaseAuth.instance.currentUser!.uid)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic value = snapshot.data;
                      if (value["status"] == "student") {
                        return EtudiantHomePage();
                      } else {
                        return LandLordHomePage();
                      }
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const AlertDialog(
                          title: Text('Error Occured while signing in'),
                          content: Text('Please Try again'),
                        );
                      }
                    }
                  });
            }
            //user is not logged in
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
