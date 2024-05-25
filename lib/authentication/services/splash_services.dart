import 'package:e_commerce/provider/data_provider.dart';
import 'package:e_commerce/routes_name.dart';
import 'package:e_commerce/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      try {
        Timer(const Duration(seconds: 2), () async {
          print("This is loggedin User: $loggedInUserEmail");
          var myUser = await getUserData(user.email, context);
          Navigator.pushReplacementNamed(
            context,
            homeScreen,
          );
        });
      } catch (e) {
        ShowAlertDialog obj = ShowAlertDialog();
        obj.alertDialog(
            context, "Error fetching user data", Colors.red, "bottom");
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, authenticationScreen);
      });
    }
  }

  Future<Map<Object?, Object?>?> getUserData(email, context) async {
    int index = email.indexOf('.com');
    String searchEmail = email.substring(0, index);
    loggedInUserEmail = searchEmail;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Registered Persons').get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> user = snapshot.value as Map;
      if (user.containsKey(searchEmail)) {
        Map<Object?, Object?> userData = user[searchEmail];
        ShowAlertDialog obj = ShowAlertDialog();
        obj.alertDialog(
            context, "Logged in as ${userData['name']}", buttonColor, "bottom");
        return userData;
      }
    }
    return null;
  }
}
