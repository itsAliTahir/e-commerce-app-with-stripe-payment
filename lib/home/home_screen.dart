import 'package:e_commerce/home/widgets/brands_selector.dart';
import 'package:e_commerce/home/widgets/cover_slider.dart';
import 'package:e_commerce/home/widgets/items_grid.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import 'widgets/myappbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Flexible(
            flex: 10,
            child: SizedBox(),
          ),
          Flexible(flex: 54, child: MyAppBar()),
          Flexible(flex: 230, child: MyCoverSlider()),
          Flexible(flex: 150, child: MyBrandSelector()),
          Flexible(flex: 250, child: MyItemsGrid()),
          Flexible(
            flex: 0,
            child: Container(color: Colors.red),
          ),
        ]),
      ),
    );
  }
}
