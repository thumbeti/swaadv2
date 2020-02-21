
class CartMenuItem {
  const CartMenuItem({
    this.id,
    this.itemName,
    this.price,
    this.minQ,
    this.reqQ,
  }) : assert(id != null, 'ID must not be null'),
        assert(itemName != null, 'ItemName must not be null'),
        assert(price != null, 'price must not be null'),
        assert(minQ != null, 'minQ must not be null'),
        assert(reqQ != null, 'minQ must not be null');

  final int id;
  final String itemName;
  final int price;
  final int minQ;
  final int reqQ;

  @override
  String toString() => '$itemName (id=$id)';
}