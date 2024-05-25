import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCartAppBarScreen extends StatelessWidget {
  const MyCartAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: screenWidth * 0.10 + 5,
              height: screenWidth * 0.10 + 5,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 246, 246),
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              )),
            ),
          ),
          Text(
            "My Cart",
            style: GoogleFonts.orbitron(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            width: screenWidth * 0.10 + 5,
            height: screenWidth * 0.10 + 5,
            margin: const EdgeInsets.only(right: 10),
          )
        ],
      ),
    );
  }
}
