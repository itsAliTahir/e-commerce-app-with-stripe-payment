import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../provider/models/items.dart';

class MyImageSlider extends StatelessWidget {
  Item item;
  MyImageSlider(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(0),
      child: ImageSlideshow(
          initialPage: 0,
          indicatorBottomPadding: 0,
          indicatorColor: Colors.black,
          height: screenHeight * 0.32,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
            print('Page changed: $value');
          },
          autoPlayInterval: 50000000,
          isLoop: true,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: ClipRRect(
                child: Hero(
                    tag: item.name.toString(),
                    child: Image.network(item.image, fit: BoxFit.contain)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: ClipRRect(
                child: Image.network(item.image, fit: BoxFit.contain),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: ClipRRect(
                child: Image.network(item.image, fit: BoxFit.contain),
              ),
            ),
          ]),
    );
  }
}
