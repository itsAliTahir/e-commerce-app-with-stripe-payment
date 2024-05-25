import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../provider/data_provider.dart';
import '../../provider/models/items.dart';
import '../../routes_name.dart';
import '../../theme.dart';

class MyFavItemsList extends StatelessWidget {
  const MyFavItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    return Expanded(
      child: FutureBuilder(
        future: itemsProvider.getFavItemsList(),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerGridView();
          } else if (snapshot.hasError) {
            // Show error message if there's an error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return const Text(" no data");
          } else {
            int itemCount = 0;
            itemCount = snapshot.data!.length != 0 ? snapshot.data!.length : 1;

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final item = snapshot.data!.length != 0
                    ? snapshot.data![index]
                    : Item(
                        id: "",
                        brand: 1,
                        itemCategory: "ada",
                        colors: [],
                        discountedPrice: 0,
                        image: " ",
                        name: " ",
                        price: 2,
                        rating: 1,
                        sizes: []);

                return snapshot.data!.length == 0
                    ? SizedBox(
                        child: Center(child: Text("NO Item in Favourites")),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, itemDetailScreen,
                              arguments: [item]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(158, 158, 158, 158),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Hero(
                                      tag: item.name.toString(),
                                      child: Image.network(item.image)),
                                ),
                              ),
                              Flexible(
                                flex: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                          item.name,
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
                                          item.colors.length < 2
                                              ? "${item.colors.length} Color"
                                              : "${item.colors.length} Colors",
                                          style: GoogleFonts.lato(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
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
                                                  text: (item.price -
                                                          item.discountedPrice)
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: 0.5,
                                  height: 70,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color:
                                      const Color.fromARGB(158, 158, 158, 158),
                                ),
                              ),
                              Flexible(
                                  flex: 20,
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          itemsProvider.removefromFav(
                                              item.name, context);
                                        },
                                        icon: const Icon(
                                          FluentIcons.delete_48_regular,
                                          size: 24,
                                        )),
                                  )),
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
