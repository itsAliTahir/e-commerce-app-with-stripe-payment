import 'package:e_commerce/favourites/widgets/fav_items_list.dart';
import 'package:flutter/material.dart';
import '../home/widgets/myappbar.dart';

class MyFavouriteScreen extends StatelessWidget {
  const MyFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Flexible(flex: 10, child: SizedBox()),
          Flexible(flex: 54, child: MyAppBar()),
          Flexible(flex: 630, child: MyFavItemsList()),
          Flexible(flex: 0, child: SizedBox()),
        ]),
      ),
    );
  }
}
