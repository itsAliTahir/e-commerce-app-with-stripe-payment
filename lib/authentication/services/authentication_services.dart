// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
import '../../routes_name.dart';

class AuthenticationServices {
  void signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      final databaseRef = FirebaseDatabase.instance.ref("Registered Persons");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      int index = email.indexOf('.com');
      String temp = email.substring(0, index);
      email.replaceAll(".", "DOT");
      email.replaceAll("#", "HASH");
      email.replaceAll("[", "sqarLeft");
      email.replaceAll("]", "sqarRight");
      email.replaceAll("\$", "DOLLAR");
      databaseRef.child(temp).set({
        "role": "user",
        "email": email,
        "name": name,
      });
// Getting User Data
      Navigator.pushReplacementNamed(context, splashScreen);
    } on FirebaseAuthException catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, e.message.toString(), Colors.red, "top");
    } catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, e.toString(), Colors.red, "top");
    }
  }

  void logout(BuildContext context) async {
    try {
      loggedInUserEmail = " ";
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, authenticationScreen);
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, "Logged Out", Colors.blueGrey, "top");
    } on FirebaseAuthException catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, e.message.toString(), Colors.red, "top");
    }
  }

  void login(String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      Navigator.pushReplacementNamed(context, splashScreen);
    } on FirebaseAuthException catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, e.message.toString(), Colors.red, "top");
    }
  }
}
