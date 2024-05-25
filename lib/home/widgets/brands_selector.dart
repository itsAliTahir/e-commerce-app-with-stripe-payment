import 'package:e_commerce/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';

class MyBrandSelector extends StatelessWidget {
  const MyBrandSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    Widget BrandButton(
        {required int id,
        required String title,
        required double size,
        required String pic}) {
      return Bounceable(
        onTap: () {
          itemsProvider.toggleBrand(id);
        },
        child: SizedBox(
          width: size * 0.2,
          height: 100,
          child: Column(
            children: [
              Container(
                width: (size * 0.2) - 15,
                height: (size * 0.2) - 15,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: itemsProvider.selectedBrands.contains(id)
                      ? LinearGradient(colors: [buttonColorLight, buttonColor])
                      : const LinearGradient(colors: [
                          Color.fromARGB(255, 246, 246, 246),
                          Color.fromARGB(255, 246, 246, 246),
                        ]),
                ),
                child: Image.asset(pic),
              ),
              const SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(
                  title,
                  style: GoogleFonts.lato(
                      fontSize: 10.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BrandButton(
                    id: 0,
                    title: "PUMA",
                    size: screenWidth,
                    pic: "assets/images/brands/puma.png"),
                BrandButton(
                    id: 1,
                    title: "NB",
                    size: screenWidth,
                    pic: "assets/images/brands/nb.png"),
                BrandButton(
                    id: 2,
                    title: "NIKE",
                    size: screenWidth,
                    pic: "assets/images/brands/nike.png"),
                BrandButton(
                    id: 3,
                    title: "ADIDAS",
                    size: screenWidth,
                    pic: "assets/images/brands/addidas.png"),
                // BrandButton(
                //     title: "CONVERSE",
                //     size: screenWidth,
                //     pic: "assets/images/brands/converse.png"),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 20),
            child: Row(
              children: [
                Text(
                  "Popular Now",
                  style: GoogleFonts.orbitron(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(65, 33, 149, 243),
                    border: Border.all(color: buttonColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    " Sale ",
                    style: GoogleFonts.orbitron(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
