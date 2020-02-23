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

  int getSelectedItemQuantity(MenuItem item) {
    int result = -1;
    selectedItems.forEach((sItem) => {
          if (item.id.toDouble() == sItem.item.id.toDouble())
            {result = sItem.quantity.toInt()}
        });
    return result;
  }

  // Adds a product to the cart
  void addProductToCart(MenuItem item) {
    bool found = false;
    selectedItems.forEach((sItem) => {
          if (item.id.toDouble() == sItem.item.id.toDouble())
            {
              sItem.quantity = sItem.quantity + 1.0,
              found = true,
           }
        });
    if (found == false) {
      selectedItems.add(new SelectedItem(item, item.minQuantity));
    }
  }

  // Removes an item from the cart.
  void removeItemFromCart(MenuItem item) {
    MenuItem itemToRemove = null;
    selectedItems.forEach((sItem) => {
          if (item.id.toDouble() == sItem.item.id.toDouble())
            {
              if (sItem.quantity.toDouble() == item.minQuantity.toDouble())
                {itemToRemove = sItem.item}
              else
                {sItem.quantity = sItem.quantity - 1}
            }
        });
    if (itemToRemove != null) {
      selectedItems.removeWhere(
          (e) => e.item.id.toDouble() == itemToRemove.id.toDouble());
    }
  }
}
