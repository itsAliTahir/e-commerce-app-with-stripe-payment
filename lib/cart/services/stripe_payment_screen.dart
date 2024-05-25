import 'dart:async';

import 'package:e_commerce/routes_name.dart';
import 'package:e_commerce/theme.dart';
import 'package:e_commerce/widgets/plain_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../provider/data_provider.dart';
import 'stripe_payment_services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    StripePaymentHandle obj = StripePaymentHandle();
    obj.stripeMakePayment(
        ((totalAmount + shippingFee)).toInt().toString(), context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return PopScope(
      onPopInvoked: (didPop) {
        totalAmount = 0.0;
      },
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 190,
                height: 190,
                child: itemsProvider.paymentStatus.toString() == doneText
                    ? Lottie.asset(
                        "assets/animations/tiBntP2lO2.json",
                        reverse: true,
                        repeat: true,
                      )
                    : itemsProvider.paymentStatus.toString() == processingText
                        ? Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Colors.black,
                              secondRingColor: buttonColor,
                              thirdRingColor: primaryColor,
                              size: 50,
                            ),
                          )
                        : Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 70,
                          ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                itemsProvider.paymentStatus.toString(),
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                height: 70,
                child: itemsProvider.paymentStatus.toString() == processingText
                    ? SizedBox()
                    : MyPlainButton(
                        text: "Go Back",
                        onTap: () {
                          Navigator.pushReplacementNamed(context, homeScreen);
                          Timer(Duration(seconds: 1),
                              () => itemsProvider.setPaymentStatus("nil"));
                        },
                        backgroundColor: Colors.black,
                        textColor: Colors.white),
              )
            ],
          ),
        ),
      )),
    );
  }
}
