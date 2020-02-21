
class MenuItem{
  String _intemName;
  String _itemOwner;
  int _minQuantity;
  int _price;
  String _image;

  MenuItem(this._intemName, this._itemOwner, this._minQuantity, this._price,
      this._image);

  MenuItem.map(dynamic obj) {
    this._intemName = obj['itemName'];
    this._itemOwner = obj['itemOwner'];
    this._minQuantity = obj['minQuantity'];
    this._price = obj['price'];
    this._image = obj['image'];
  }

  String get itemName => _intemName;
  String get itemOwner => _itemOwner;
  int get minQuantity => _minQuantity;
  int get price => _price;
  String get image => _image;

  Map<String,dynamic> toMap() {
    var map = new Map<String,dynamic>();
    map['itemName'] = _intemName;
    map['itemOwner'] = _itemOwner;
    map['minQuantity'] = _minQuantity;
    map['price'] = _price;
    map['image'] = _image;
    return map;
  }

  MenuItem.fromMap(Map<String,dynamic> map) {
    this._intemName = map['itemName'];
    this._itemOwner = map['itemOwner'];
    this._minQuantity = map['minQuantity'];
    this._price = map['price'];
    this._image = map['image'];
  }
}