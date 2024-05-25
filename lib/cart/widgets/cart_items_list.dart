import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';
import '../../theme.dart';

class MyCartItemsList extends StatelessWidget {
  const MyCartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Expanded(
      child: FutureBuilder(
        future: itemsProvider.getCartItemsList(),
        builder: (context, AsyncSnapshot<List<CartItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerGridView();
          } else if (snapshot.hasError) {
            // Show error message if there's an error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return const Text(" no data");
          } else {
            int itemCount = 0;
            itemCount = snapshot.data!.isNotEmpty ? snapshot.data!.length : 1;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                CartItem cart = snapshot.data!.isNotEmpty
                    ? snapshot.data![index]
                    : CartItem(
                        item: Item(
                            id: " ",
                            brand: 0,
                            itemCategory: " ",
                            colors: [],
                            discountedPrice: 0,
                            image: " ",
                            name: " ",
                            price: 0,
                            rating: 0,
                            sizes: []),
                        colorIndex: 0,
                        quantity: 0,
                        sizeIndex: 0,
                        name: " ",
                      );

                if (snapshot.data!.isNotEmpty) {
                  totalAmount = 0.0;
                  for (int i = 0; i < snapshot.data!.length; i++) {
                    totalAmount = totalAmount +
                        (snapshot.data![i].quantity *
                            (snapshot.data![i].item.price -
                                snapshot.data![i].item.discountedPrice));
                    print(totalAmount);
                  }
                }
                return snapshot.data!.isEmpty
                    ? const SizedBox(
                        child: Center(child: Text("NO Item In Cart")),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(158, 158, 158, 158),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 40,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Image.network(cart.item.image),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 60,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              cart.name,
                                              style: GoogleFonts.lato(
                                                  fontSize: 12.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            child: Text(
                                              "${cart.item.itemCategory}",
                                              style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            itemsProvider.deleteCartItem(
                                                cart.name, context);
                                          },
                                          child: Icon(
                                            FluentIcons.delete_48_regular,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 30,
                                      ),
                                      cart.item.discountedPrice != 0
                                          ? Container(
                                              child: Text(
                                                "\$${(cart.quantity * (cart.item.price)).toString()}",
                                                style: GoogleFonts.lato(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      Colors.deepOrange,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '\$',
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: buttonColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: (cart.quantity *
                                                        (cart.item.price -
                                                            cart.item
                                                                .discountedPrice))
                                                    .toString(),
                                                style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              DottedLine(
                                dashLength: 5,
                                dashColor: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 25, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      child: Text(
                                        "Colour: ",
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          color: HexColor(
                                              "#${cart.item.colors[cart.colorIndex.toInt()]}"),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 205, 205, 205)),
                                          borderRadius:
                                              BorderRadius.circular(10 - 4)),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      child: Text(
                                        "Size: ${cart.item.sizes[cart.sizeIndex.toInt()]}",
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      child: Text(
                                        "QTY: ${cart.quantity.toInt()}",
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      );
              },
            );
          }
        },
      ),
    );
  }
}

class ShimmerGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(158, 158, 158, 158),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 40,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 242, 242, 242),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              Flexible(
                flex: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 200,
                          height: 20,
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 20,
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
