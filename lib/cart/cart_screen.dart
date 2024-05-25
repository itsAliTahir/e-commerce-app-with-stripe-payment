import 'package:e_commerce/cart/widgets/mycart_appbar.dart';
import 'package:e_commerce/cart/widgets/payment_information_and_button.dart';
import 'package:e_commerce/home/widgets/brands_selector.dart';
import 'package:e_commerce/home/widgets/cover_slider.dart';
import 'package:e_commerce/home/widgets/items_grid.dart';
import 'package:e_commerce/widgets/gradient_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../theme.dart';
import 'widgets/cart_items_list.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        totalAmount = 0.0;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            Flexible(flex: 7, child: MyCartAppBarScreen()),
            Flexible(flex: 53, child: MyCartItemsList()),
            Flexible(flex: 40, child: MyPaymentInforMationAndButton()),
          ]),
        ),
      ),
    );
  }
}
