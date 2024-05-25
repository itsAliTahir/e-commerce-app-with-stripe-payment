import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPlainButton extends StatelessWidget {
  String text;
  Function onTap;
  Color backgroundColor;
  Color textColor;
  MyPlainButton(
      {required this.text,
      required this.onTap,
      required this.backgroundColor,
      required this.textColor,
      super.key});

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
            color: backgroundColor,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 97, 97, 97),
                  blurRadius: 2)
            ]),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.orbitron(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
