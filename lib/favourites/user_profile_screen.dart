import 'package:e_commerce/favourites/widgets/fav_items_list.dart';
import 'package:flutter/material.dart';
import '../home/widgets/myappbar.dart';

class MyUserProfileScreen extends StatelessWidget {
  const MyUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            "User Profile Screen\n Not Made Yet",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
