import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';
import '../../routes_name.dart';

class MyCoverSlider extends StatelessWidget {
  const MyCoverSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: ImageSlideshow(
        initialPage: 0,
        indicatorColor: Colors.transparent,
        indicatorBackgroundColor: Colors.transparent,
        onPageChanged: (value) {},
        autoPlayInterval: 5000,
        isLoop: true,
        children: [
          GestureDetector(
            onTap: () {
              Item item = itemsProvider
                  .getCoverItem("Future 4 1 Netfit XX 17 2 Solidly Nailed");
              Navigator.pushNamed(context, itemDetailScreen, arguments: [item]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
                  Image.asset("assets/images/cover/1.png", fit: BoxFit.cover),
            ),
          ),
          GestureDetector(
            onTap: () {
              Item item = itemsProvider.getCoverItem("Stacked Logo Tee");
              Navigator.pushNamed(context, itemDetailScreen, arguments: [item]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
                  Image.asset("assets/images/cover/2.png", fit: BoxFit.cover),
            ),
          ),
          GestureDetector(
            onTap: () {
              Item item = itemsProvider.getCoverItem("ESS Jr Baseball Cap");
              Navigator.pushNamed(context, itemDetailScreen, arguments: [item]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
                  Image.asset("assets/images/cover/3.png", fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
