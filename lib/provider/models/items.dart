class Item {
  final String id;
  final int brand;
  final String itemCategory;
  final List<String> colors;
  final double discountedPrice;
  final String image;
  final String name;
  final double price;
  final double rating;
  final List<dynamic> sizes;

  Item({
    required this.id,
    required this.brand,
    required this.itemCategory,
    required this.colors,
    required this.discountedPrice,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.sizes,
  });

  factory Item.fromJson(String id, Map<dynamic, dynamic> json) {
    return Item(
      id: id,
      brand: json['brand'],
      itemCategory: json['item_category'],
      colors: List<String>.from(json['colors']),
      discountedPrice: json['discountedprice'].toDouble(),
      image: json['image'],
      name: json['name'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      sizes: List<dynamic>.from(json['sizes']),
    );
  }
}

class CartItem {
  final Item item;
  final String name;
  final double sizeIndex;
  final double colorIndex;
  final double quantity;

  CartItem(
      {required this.item,
      required this.name,
      required this.sizeIndex,
      required this.colorIndex,
      required this.quantity});
}

class Cart {
  final String name;
  final double sizeIndex;
  final double colorIndex;
  final double quantity;

  Cart(
      {required this.name,
      required this.sizeIndex,
      required this.colorIndex,
      required this.quantity});

  factory Cart.fromJson(String id, Map<dynamic, dynamic> json) {
    return Cart(
      name: json['item'],
      quantity: json['quantity'].toDouble(),
      sizeIndex: json['sizeIndex'].toDouble(),
      colorIndex: json['colorIndex'].toDouble(),
    );
  }
}
