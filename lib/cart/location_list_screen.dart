import 'package:flutter/material.dart';

class MyLocationListScreen extends StatefulWidget {
  const MyLocationListScreen({super.key});

  @override
  State<MyLocationListScreen> createState() => _MyLocationListScreenState();
}

class _MyLocationListScreenState extends State<MyLocationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          // Flexible(flex: 7, child: MyCartAppBarScreen()),
          // Flexible(flex: 53, child: MyCartItemsList()),
          // Flexible(flex: 40, child: MyPaymentInforMationAndButton()),
        ]),
      ),
    );
  }
}
