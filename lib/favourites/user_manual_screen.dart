import 'package:e_commerce/favourites/widgets/fav_items_list.dart';
import 'package:flutter/material.dart';
import '../home/widgets/myappbar.dart';

class MyUserManualScreen extends StatelessWidget {
  const MyUserManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            "User Manual Screen\n Not Made Yet",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
