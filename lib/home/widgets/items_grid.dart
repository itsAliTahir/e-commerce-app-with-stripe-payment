import 'package:e_commerce/provider/data_provider.dart';
import 'package:e_commerce/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../provider/models/items.dart';

class MyItemsGrid extends StatelessWidget {
  MyItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var itemsProvider = Provider.of<ItemsProvider>(context);
    print("object");
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: FutureBuilder(
        future: itemsProvider.getItemsList(),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerGridView();
          } else if (snapshot.hasError) {
            // Show error message if there's an error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return const Text(" no data");
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, itemDetailScreen,
                        arguments: [item]);
                  },
                  child: SizedBox(
                    // height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 160,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 242, 242),
                              borderRadius: BorderRadius.circular(20)),
                          child: Hero(
                              tag: item.name.toString(),
                              child: Image.network(item.image)),
                        ),
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
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 200,
                  height: 160,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 242, 242, 242),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    height: 30,
                    width: 200,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    height: 10,
                    width: 50,
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
