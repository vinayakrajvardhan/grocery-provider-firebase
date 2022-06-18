import 'package:flutter/material.dart';
import 'package:grocery_implementation/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishListItems = {};
  Map<String, WishlistModel> get getWishListItems => _wishListItems;

  void addRemoveProductToWishlist({required String productId}) {
    if (_wishListItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishListItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
      notifyListeners();
    }
  }

  void removeOneItem(String productId) {
    _wishListItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishListItems.clear();
    notifyListeners();
  }
}
