import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/plain_button.dart';

class QuantityNAddToCart extends StatefulWidget {
  Item item;
  QuantityNAddToCart(this.item, {super.key});

  @override
  State<QuantityNAddToCart> createState() => _QuantityNAddToCartState();
}

class _QuantityNAddToCartState extends State<QuantityNAddToCart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Row(
      children: [
        Bounceable(
          onTap: () {
            setState(() {
              if (quantity > 1) {
                quantity--;
              }
            });
          },
          child: Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 205, 205, 205)),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "-",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 104, 104, 104),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: screenWidth * 0.1,
          width: screenWidth * 0.14,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 205, 205, 205)),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: FittedBox(
              child: Text(
                quantity.toString(),
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 104, 104, 104),
                ),
              ),
            ),
          ),
        ),
        Bounceable(
          onTap: () {
            setState(() {
              if (quantity < 5) {
                quantity++;
              }
            });
          },
          child: Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 205, 205, 205)),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "+",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 104, 104, 104),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        MyPlainButton(
            text: "  ADD TO CART  ",
            textColor: Colors.white,
            backgroundColor: Colors.black,
            onTap: () {
              if (colorIndex != -1 && sizeIndex != -1) {
                itemsProvider.addToCart(
                    widget.item.name, quantity, colorIndex, sizeIndex, context);
              } else {
                ShowAlertDialog obj = ShowAlertDialog();
                obj.alertDialog(context, "Please Select Size And Color",
                    Colors.blueGrey, "bottom");
              }
            }),
      ],
    );
  }
}
