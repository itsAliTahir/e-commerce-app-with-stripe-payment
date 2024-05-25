import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:e_commerce/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../theme.dart';
import '../../widgets/plain_button.dart';
import '../services/stripe_payment_services.dart';

class MyPaymentInforMationAndButton extends StatefulWidget {
  MyPaymentInforMationAndButton({super.key});

  @override
  State<MyPaymentInforMationAndButton> createState() =>
      _MyPaymentInforMationAndButtonState();
}

class _MyPaymentInforMationAndButtonState
    extends State<MyPaymentInforMationAndButton> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    Widget TitleNAmount({required String title, required String amount}) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$',
                    style: GoogleFonts.lato(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: buttonColor,
                    ),
                  ),
                  TextSpan(
                    text: amount,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder(
      future: itemsProvider.getCartItemsList(),
      builder: (context, snapshot) => totalAmount == 0.0
          ? const SizedBox()
          : DelayedDisplay(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(160, 202, 202, 202),
                          offset: Offset(0, -8),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: [
                    Bounceable(
                      onTap: () {},
                      child: Container(
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 228, 228, 228)),
                            color: const Color.fromARGB(255, 253, 253, 253),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      'Promo Code Or Voucher',
                                      style: GoogleFonts.orbitron(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      'Savings with Your Promo Code or Voucher!',
                                      style: GoogleFonts.orbitron(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TitleNAmount(
                        title: "Sub Total", amount: totalAmount.toString()),
                    TitleNAmount(
                        title: "Shipping", amount: (shippingFee).toString()),
                    const DottedLine(
                      dashLength: 10,
                      dashColor: Color.fromARGB(255, 218, 218, 218),
                    ),
                    const Spacer(),
                    TitleNAmount(
                        title: "Total",
                        amount: (totalAmount + shippingFee).toString()),
                    const Spacer(),
                    SizedBox(
                      height: 65,
                      child: MyPlainButton(
                        onTap: () async {
                          itemsProvider.setPaymentStatus(processingText);
                          Navigator.of(context)
                              .pushReplacementNamed(paymentScreen);
                        },
                        text: "PROCEED TO PAY",
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
