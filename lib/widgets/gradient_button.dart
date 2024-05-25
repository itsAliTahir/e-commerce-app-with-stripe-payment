import 'package:e_commerce/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class MyGradientButton extends StatelessWidget {
  String text;
  Function onTap;
  MyGradientButton({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                buttonColorLight,
                buttonColor,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 97, 97, 97),
                  blurRadius: 2)
            ]),
        child: Center(
          child: Text(
            text,
            // style: const TextStyle(
            //     color: Colors.white, fontWeight: FontWeight.bold),
            style: GoogleFonts.orbitron(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
