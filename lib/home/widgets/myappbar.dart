import 'package:e_commerce/routes_name.dart';
import 'package:e_commerce/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../authentication/services/authentication_services.dart';
import '../../provider/data_provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var itemsProvider = Provider.of<ItemsProvider>(context);
    print(screenHeight);
    print(screenWidth);
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 246, 246),
              borderRadius: BorderRadius.circular(10),
            ),
            width: screenWidth * 0.65,
            height: screenWidth * 0.10 + 5,
            child: TextFormField(
              // controller: controller,
              keyboardType: TextInputType.text,
              autocorrect: false,
              // validator: validator,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FluentIcons.search_48_regular,
                    color: Colors.black,
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 7, left: 15, right: 15),
                  hintText: "Search",
                  hintStyle: GoogleFonts.lato(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 10)),
            ),
          ),
          GestureDetector(
            onTap: () {
              totalAmount = 0.0;
              itemsProvider.setAlertIcon(false);
              Navigator.of(context).pushNamed(cartScreen);
            },
            child: Container(
              width: screenWidth * 0.10 + 5,
              height: screenWidth * 0.10 + 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(FluentIcons.cart_24_regular)),
                  Positioned(
                    right: 10,
                    top: 12,
                    child: itemsProvider.isAlertCartIcon
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: buttonColorLight,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              AuthenticationServices obj = AuthenticationServices();
              obj.logout(context);
            },
            child: Container(
              width: screenWidth * 0.10 + 5,
              height: screenWidth * 0.10 + 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  // const Center(child: Icon(FluentIcons.arrow_exit_20_regular)),
                  const Center(child: Icon(Icons.more_vert_rounded)),
            ),
          ),
        ],
      ),
    );
  }
}
