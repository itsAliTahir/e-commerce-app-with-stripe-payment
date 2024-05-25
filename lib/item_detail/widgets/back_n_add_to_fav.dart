import 'package:e_commerce/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';

class BackNAddToFav extends StatelessWidget {
  late Item item;
  BackNAddToFav(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Bounceable(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios_rounded)),
          item.rating > 4.3
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        FluentIcons.crown_24_filled,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "High Rated",
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Bounceable(
              onTap: () {
                itemsProvider.toggleFavourite(context);
              },
              child: itemsProvider.isFavourite
                  ? Icon(
                      Icons.favorite,
                      color: buttonColor,
                    )
                  : const Icon(Icons.favorite_border_outlined))
        ],
      ),
    );
  }
}
