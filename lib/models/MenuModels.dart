import 'package:json_annotation/json_annotation.dart';

part 'MenuModels.g.dart';

@JsonSerializable()
class SelectedItem {
  MenuItem item;
  int quantity;

  SelectedItem(item, this.quantity): item = item ?? MenuItem;

  factory SelectedItem.fromJson(Map<String, dynamic> json) => _$SelectedItemFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedItemToJson(this);
}

@JsonSerializable()
class MenuItem{
  int id;
  String itemName;
  String itemOwner;
  int minQuantity;
  int price;
  String image;
  String description;

  MenuItem(this.id, this.itemName, this.itemOwner, this.minQuantity, this.price,
      this.image, this.description);

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}