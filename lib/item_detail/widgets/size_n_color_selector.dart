import 'package:e_commerce/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';

class SizeNColorSelector extends StatefulWidget {
  Item item;
  SizeNColorSelector(this.item, {super.key});

  @override
  State<SizeNColorSelector> createState() => _SizeNColorSelectorState();
}

class _SizeNColorSelectorState extends State<SizeNColorSelector> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.018,
        ),
        const Divider(),
        SizedBox(
          height: screenHeight * 0.018,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Size",
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.010,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < widget.item.sizes.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (sizeIndex == i) {
                          sizeIndex = -1;
                        } else {
                          sizeIndex = i;
                        }
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: sizeIndex == i
                              ? buttonColorDim
                              : Colors.transparent,
                          border: Border.all(
                              color: sizeIndex == i
                                  ? buttonColor
                                  : const Color.fromARGB(255, 205, 205, 205)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            widget.item.sizes[i].toString(),
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: sizeIndex == i
                                  ? buttonColor
                                  : const Color.fromARGB(255, 104, 104, 104),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.018,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Color",
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.010,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < widget.item.colors.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (colorIndex == i) {
                          colorIndex = -1;
                        } else {
                          colorIndex = i;
                        }
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: colorIndex == i
                                  ? buttonColor
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#${widget.item.colors[i]}"),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 205, 205, 205)),
                            borderRadius: BorderRadius.circular(10 - 4)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
