// ignore_for_file: prefer_const_constructors

import 'package:delayed_display/delayed_display.dart';
import 'package:e_commerce/item_detail/widgets/back_n_add_to_fav.dart';
import 'package:e_commerce/item_detail/widgets/image_slider.dart';
import 'package:e_commerce/item_detail/widgets/quantity_n_addtocart.dart';
import 'package:e_commerce/item_detail/widgets/size_n_color_selector.dart';
import 'package:e_commerce/provider/models/items.dart';
import 'package:e_commerce/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';
import '../theme.dart';
import 'widgets/title_n_amount.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  var builds = 0;
  void initState() {
    super.initState();
    quantity = 1;
    colorIndex = -1;
    sizeIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final List<Item> items =
        ModalRoute.of(context)!.settings.arguments as List<Item>;
    var itemsProvider = Provider.of<ItemsProvider>(context);

    final item = items[0];
    if (builds == 0) {
      builds++;

      itemsProvider.initializeFavouriteItem(item.name);
    }
    return PopScope(
      onPopInvoked: (didPop) {
        colorIndex = -1;
        sizeIndex = -1;
        quantity = 1;
        totalAmount = 0.0;
        itemsProvider.setFavouriteItem(item.name);
      },
      child: Scaffold(
        backgroundColor: itemBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  flex: 46,
                  child: Container(
                    color: itemBackgroundColor,
                    child: Column(
                      children: [
                        BackNAddToFav(item),
                        MyImageSlider(item),
                      ],
                    ),
                  )),
              Flexible(
                  flex: 4,
                  child: DelayedDisplay(
                    child: Container(),
                  )),
              Flexible(
                  flex: 54,
                  child: DelayedDisplay(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.063,
                          right: screenWidth * 0.063,
                          top: screenHeight * 0.030),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(160, 202, 202, 202),
                              offset: Offset(0, -8),
                              blurRadius: 10)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          MyTitleNAmount(item),
                          SizeNColorSelector(item),
                          const Spacer(),
                          QuantityNAddToCart(item),
                          SizedBox(
                            height: screenHeight * 0.018,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
