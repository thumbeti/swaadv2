import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/models/MenuModels.dart';

class CartService {

  Stream<QuerySnapshot> allItems;

  // The IDs and quantities of products currently in the cart.
  final _productsInCart = <int, int>{};

  final selectedItems = List<SelectedItem>();

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

  /*
  // Adds a product to the cart
  void addProductToCart_2(DocumentSnapshot item) {
    bool found = false;
    
    selectedItems.forEach((sItem) => {
      if (item['id']  == sItem.mItem['id']) {
        sItem.quantity = sItem.quantity + 1,
        found = true
      }
    });
    if (found == false) {
      selectedItems.add(new SelectedItem(item, item['minQuantity']));
    }
  }
*/
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