import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {

  Stream<QuerySnapshot> allItems;

  // The IDs and quantities of products currently in the cart.
  final _productsInCart = <int, int>{};

  void setAllItems(Stream<QuerySnapshot> allItems) {
      this.allItems = allItems;
  }

  Map<int, int> get productsInCart {
    return Map.from(_productsInCart);
  }

  int getProductReqQ(int key) {
    return _productsInCart.containsKey(key)? _productsInCart[key]: -1;
  }
  // Adds a product to the cart.
  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 50;
    } else {
      _productsInCart[productId]++;
    }
  }

  // Removes an item from the cart.
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 50) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }
  }
}