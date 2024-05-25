import 'package:alert_banner/widgets/alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'models/items.dart';
import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

class ShowAlertDialog {
  void alertDialog(
      BuildContext context, String title, Color color, String location) {
    AlertBannerLocation loc = location == "top"
        ? AlertBannerLocation.top
        : AlertBannerLocation.bottom;
    showAlertBanner(
        context, () => print("TAPPED"), AlertBannerChild(title, color),
        alertBannerLocation: loc);
  }
}

class AlertBannerChild extends StatelessWidget {
  String title;
  Color color;
  AlertBannerChild(this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80, top: 60),
      width: double.infinity,
      height: 40,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

enum AuthScreen {
  login,
  forgotPassword,
  register,
}

var loggedInUserEmail = "nil";

// Add to Cart
int quantity = 1;
int sizeIndex = -1;
int colorIndex = -1;

class AuthProvider with ChangeNotifier {
  var _currentScreen = AuthScreen.login;
  get currentScreen => _currentScreen;

  void screenSetter(AuthScreen value) {
    _currentScreen = value;
    notifyListeners();
  }
}

class ItemsProvider with ChangeNotifier {
  List<Item> _itemsList = [];
  bool gotData = false;
  List<int> _selectedBrands = [];
  bool _isFavourite = false;
  bool _isAlertCartIcon = true;
  String _paymentStatus = "nil";
  get isAlertCartIcon => _isAlertCartIcon;
  get isFavourite => _isFavourite;
  List<int> get selectedBrands => _selectedBrands;

  get paymentStatus => _paymentStatus;

  void setAlertIcon(bool value) {
    _isAlertCartIcon = value;
    notifyListeners();
  }

  void setPaymentStatus(String value) {
    _paymentStatus = value;
    notifyListeners();
  }

  void toggleBrand(int id) {
    if (_selectedBrands.contains(id)) {
      _selectedBrands.remove(id);
    } else {
      _selectedBrands.add(id);
    }
    notifyListeners();
  }

  void toggleFavourite(BuildContext context) {
    _isFavourite = !_isFavourite;
    ShowAlertDialog obj = ShowAlertDialog();
    _isFavourite
        ? obj.alertDialog(context, "Added To Favourite", buttonColor, "top")
        : obj.alertDialog(
            context, "Removed From Favourite", Colors.blueGrey, "top");
    notifyListeners();
  }

  void addToCart(
    String item,
    int quantity,
    int pickedColor,
    int pickedSize,
    BuildContext context,
  ) {
    try {
      final databaseRef = FirebaseDatabase.instance.ref("Registered Persons");
      databaseRef.child(loggedInUserEmail).child("cart").child(item).set({
        "item": item,
        "quantity": quantity,
        "colorIndex": pickedColor,
        "sizeIndex": pickedSize,
      });
      Navigator.of(context).pop();
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(
          context, "Added To Cart Successfully!", buttonColor, "bottom");
      _isAlertCartIcon = true;
    } catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, "Failed To Add To Cart! Please Retry",
          Colors.redAccent, "bottom");
    }
  }

  Future<bool> initializeFavouriteItem(String item) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref
          .child("Registered Persons")
          .child(loggedInUserEmail)
          .child("favs")
          .get();
      if (snapshot.exists) {
        List<dynamic> data = [];
        data = snapshot.value as List;
        if (data.contains(item)) {
          _isFavourite = true;

          print("Favourite Found");
        } else {
          _isFavourite = false;
          print("Favourite Not Found");
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void removefromFav(String item, BuildContext context) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final favsRef = ref
          .child("Registered Persons")
          .child(loggedInUserEmail)
          .child("favs");

      final snapshot = await favsRef.get();
      if (snapshot.exists) {
        List<dynamic> data = [];
        List<dynamic> tempList = [];
        tempList = snapshot.value as List;
        for (int i = 0; i < tempList.length; i++) {
          data.add(tempList[i]);
        }
        if (data.contains(item)) {
          data.remove(item);
          ref
              .child('Registered Persons')
              .child(loggedInUserEmail)
              .update({'favs': data});
        }
      }
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(
          context, "Removed From Favourite", Colors.blueGrey, "bottom");
      notifyListeners();
    } catch (e) {
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(
          context, "Failed To Remove From Cart", Colors.redAccent, "bottom");
    }
  }

  void setFavouriteItem(String item) async {
    print("setting");
    final ref = FirebaseDatabase.instance.ref();
    final favsRef =
        ref.child("Registered Persons").child(loggedInUserEmail).child("favs");

    final snapshot = await favsRef.get();

    if (snapshot.exists) {
      List<dynamic> data = [];
      List<dynamic> tempList = [];
      tempList = snapshot.value as List;
      for (int i = 0; i < tempList.length; i++) {
        data.add(tempList[i]);
      }
      if (data.contains(item)) {
        if (_isFavourite == false) {
          data.remove(item);
        }
      } else {
        if (_isFavourite == true) {
          data.add(item);
        }
      }
      ref
          .child('Registered Persons')
          .child(loggedInUserEmail)
          .update({'favs': data});
    } else {
      if (isFavourite) {
        favsRef.set([item]);
      }
    }
    _isFavourite = false;
    notifyListeners();
  }

  Future<String> getBrandName(int id) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Brands').get();

      if (snapshot.exists) {
        List<dynamic> data = [];
        data = snapshot.value as List;
        if (data[id] != null) {
          return data[id]['name'];
        }
        return " ";
      }

      return "nil";
    } catch (e) {
      return "nil";
    }
  }

  Future<List<Item>> getItemsList() async {
    try {
      if (_itemsList.isEmpty) {
        final ref = FirebaseDatabase.instance.ref();
        final snapshot = await ref.child('Items').get();
        if (snapshot.exists) {
          Map<dynamic, dynamic> itemsData = snapshot.value as Map;
          _itemsList = [];
          itemsData.forEach((key, value) {
            Item item = Item.fromJson(key, value);
            _itemsList.add(item);
          });
          _itemsList.shuffle();
        }
      }
    } catch (e) {}
    print(_itemsList.length);
    if (_selectedBrands.isEmpty) {
      return _itemsList.toSet().toList();
    } else {
      List<Item> filteredItems = _itemsList
          .where((item) => _selectedBrands.contains(item.brand))
          .toList();
      return filteredItems.toSet().toList();
    }
  }

  Future<List<Item>> getFavItemsList() async {
    final ref = FirebaseDatabase.instance.ref();
    final favsRef =
        ref.child("Registered Persons").child(loggedInUserEmail).child("favs");

    final snapshot = await favsRef.get();
    List<dynamic> data = [];
    List<dynamic> tempList = [];
    if (snapshot.exists) {
      tempList = snapshot.value as List;
      for (int i = 0; i < tempList.length; i++) {
        data.add(tempList[i]);
      }
    }
    return _itemsList.where((item) => data.contains(item.name)).toList();
  }

  Future<List<CartItem>> getCartItemsList() async {
    final ref = FirebaseDatabase.instance.ref();
    final favsRef =
        ref.child("Registered Persons").child(loggedInUserEmail).child("cart");

    final snapshot = await favsRef.get();
    List<Cart> data = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> itemsData = snapshot.value as Map;

      data = [];
      itemsData.forEach((key, value) {
        Cart item = Cart.fromJson(key, value);

        data.add(Cart(
            name: item.name,
            sizeIndex: item.sizeIndex,
            colorIndex: item.colorIndex,
            quantity: item.quantity));
      });
    }

    final List<CartItem> cartItemList = [];
    final tempItemList = _itemsList
        .where((iteme) => data.any((datum) => datum.name == iteme.name))
        .toList();
// Sorting Lists
    List<dynamic> sortedData = [];
    List<dynamic> sortedTempItemList = [];
    List<List<dynamic>> pairedList = [];
    for (var item in data) {
      var matchingItem = tempItemList.firstWhere(
        (tempItem) => tempItem.name == item.name,
      );
      if (matchingItem != null) {
        pairedList.add([item, matchingItem]);
      }
    }
    pairedList.sort((a, b) => (a[0].name).compareTo(b[0].name));
    for (var pair in pairedList) {
      sortedData.add(pair[0]);
      sortedTempItemList.add(pair[1]);
    }
//
    totalAmount = 0.0;
    for (int i = 0; i < sortedTempItemList.length; i++) {
      cartItemList.add(CartItem(
          item: sortedTempItemList[i],
          name: sortedData[i].name,
          sizeIndex: sortedData[i].sizeIndex,
          colorIndex: sortedData[i].colorIndex,
          quantity: sortedData[i].quantity));
      print(sortedData[i].quantity);

      totalAmount = totalAmount +
          (sortedData[i].quantity *
              (sortedTempItemList[i].price -
                  sortedTempItemList[i].discountedPrice));
    }

    return cartItemList;
  }

  Future<void> deleteCartItem(String cartItemId, BuildContext context) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final cartItemRef = ref
          .child("Registered Persons")
          .child(loggedInUserEmail)
          .child("cart")
          .child(cartItemId);
      // Remove the cart item from the database
      await cartItemRef.remove();
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(context, "Removed From Cart", Colors.blueGrey, "bottom");
      notifyListeners();
    } catch (error) {
      print("Failed to delete cart item: $error");
      ShowAlertDialog obj = ShowAlertDialog();
      obj.alertDialog(
          context, "Failed To Delete Cart Item", Colors.redAccent, "bottom");
      // Handle error here, if necessary
    }
  }

  Item getCoverItem(name) {
    try {
      return _itemsList.firstWhere((element) => element.name == name,
          orElse: () => _itemsList[0]);
    } catch (e) {
      print(e);
    }
    return _itemsList[0];
  }

  Future<void> emptyCart() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final cartItemRef = ref
          .child("Registered Persons")
          .child(loggedInUserEmail)
          .child("cart");
      // Remove the cart item from the database
      await cartItemRef.remove();
      notifyListeners();
    } catch (error) {
      // Handle error here, if necessary
    }
  }
}
