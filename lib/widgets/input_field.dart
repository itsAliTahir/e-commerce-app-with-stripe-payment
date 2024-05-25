import 'package:e_commerce/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatelessWidget {
  String title;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool error;
  bool obscureText;
  IconData prefixIcon;
  TextInputType? keyboardType;

  MyInputField(
      {required this.title,
      required this.controller,
      required this.validator,
      required this.error,
      this.prefixIcon = FluentIcons.pen_16_filled,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
        validator: validator,
        style: const TextStyle(fontSize: 14),
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: buttonColor,
            ),
            suffixIcon: Icon(
              Icons.error,
              color: error == false ? Colors.transparent : Colors.redAccent,
              size: 20,
            ),
            contentPadding: const EdgeInsets.only(top: 7, left: 15, right: 15),
            hintText: title,
            hintStyle: GoogleFonts.lato(
              color: buttonColor,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100), gapPadding: 10)),
      ),
    );
  }
}
