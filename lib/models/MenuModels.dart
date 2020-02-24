import 'package:json_annotation/json_annotation.dart';

part 'MenuModels.g.dart';

@JsonSerializable()
class SwaadOrder {
  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  final DateTime deliveryTime;

  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  final DateTime orderReceivedDate;

  final String orderType;
  final String orderBy;
  final String status;
  List<SelectedItem> items;

  SwaadOrder(this.deliveryTime, this.orderReceivedDate, this.orderType,
      this.orderBy, this.status, this.items);

  factory SwaadOrder.fromJson(Map<String, dynamic> json) => _$SwaadOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SwaadOrderToJson(this);

  static DateTime _dateTimeFromEpochUs(int us) =>
      us == null ? null : DateTime.fromMicrosecondsSinceEpoch(us);

  static int _dateTimeToEpochUs(DateTime dateTime) =>
      dateTime?.microsecondsSinceEpoch;

}

@JsonSerializable()
class SelectedItem {
  MenuItem item;
  double quantity;

  SelectedItem(item, this.quantity): item = item ?? MenuItem;
  factory SelectedItem.fromJson(Map<String, dynamic> json) => _$SelectedItemFromJson(json);
  Map<String, dynamic> toJson() => _$SelectedItemToJson(this);
}

@JsonSerializable()
class MenuItem{
  double id;
  String itemName;
  String itemOwner;
  double minQuantity;
  double price;
  String image;
  String description;

  MenuItem(this.id, this.itemName, this.itemOwner, this.minQuantity, this.price,
      this.image, this.description);
  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}