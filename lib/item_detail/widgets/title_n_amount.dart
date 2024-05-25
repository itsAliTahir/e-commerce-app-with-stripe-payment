import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';
import '../../theme.dart';

class MyTitleNAmount extends StatelessWidget {
  Item item;
  MyTitleNAmount(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (screenWidth * 0.7) - ((screenWidth * 0.063) / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: GoogleFonts.orbitron(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              FutureBuilder(
                initialData: "NIL",
                future: itemsProvider.getBrandName(item.brand),
                builder: (context, snapshot) => FittedBox(
                  child: Text(
                    "${snapshot.data}: ${item.itemCategory}",
                    style: GoogleFonts.orbitron(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: (screenWidth * 0.23) - ((screenWidth * 0.063) / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${item.price.toString()}",
                style: GoogleFonts.orbitron(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: item.discountedPrice != 0
                      ? Colors.deepOrange
                      : Colors.transparent,
                  decorationThickness: 2,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: item.discountedPrice != 0
                      ? Colors.grey
                      : Colors.transparent,
                ),
              ),
              FittedBox(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$',
                        style: GoogleFonts.orbitron(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: buttonColor,
                        ),
                      ),
                      TextSpan(
                        text: (item.price - item.discountedPrice).toString(),
                        style: GoogleFonts.orbitron(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
