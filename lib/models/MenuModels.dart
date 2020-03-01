import 'package:json_annotation/json_annotation.dart';

part 'MenuModels.g.dart';

@JsonSerializable(anyMap: true)
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

@JsonSerializable(anyMap: true)
class SelectedItem {
  MenuItem item;
  double quantity;

  SelectedItem(item, this.quantity): item = item ?? MenuItem;
  //factory SelectedItem.fromJson(Map<String, dynamic> json) => _$SelectedItemFromJson(json);
  factory SelectedItem.fromJson(Map<String, dynamic> json) {
    return SelectedItem(
      MenuItem.fromJson(Map<String, dynamic>.from(json['item'])),
      (json['quantity'] as num)?.toDouble(),
    );
  }
  Map<String, dynamic> toJson() => _$SelectedItemToJson(this);
}

@JsonSerializable(anyMap: true)
class SwaadOrder {
  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  DateTime deliveryTime;

  @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  DateTime orderReceivedDate;

  String orderId;
  String orderType;
  String orderBy;
  String status;
  List<SelectedItem> items;

  SwaadOrder();

  //factory SwaadOrder.fromJson(Map<String, dynamic> json) => _$SwaadOrderFromJson(json);

  factory SwaadOrder.fromJson(Map<String, dynamic> json) {
    return SwaadOrder()
      ..deliveryTime =
      SwaadOrder._dateTimeFromEpochUs(json['deliveryTime'] as int)
      ..orderReceivedDate =
      SwaadOrder._dateTimeFromEpochUs(json['orderReceivedDate'] as int)
      ..orderId = json['orderId'] as String
      ..orderType = json['orderType'] as String
      ..orderBy = json['orderBy'] as String
      ..status = json['status'] as String
      ..items = (json['items'] as List)?.map((e) =>
                      e == null ? null : SelectedItem.fromJson(Map<String, dynamic>.from(e)))
                      ?.toList();
      //..items = (json['items'] as List).map((i) => SelectedItem.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() => _$SwaadOrderToJson(this);

  static DateTime _dateTimeFromEpochUs(int us) =>
      us == null ? null : DateTime.fromMicrosecondsSinceEpoch(us);

  static int _dateTimeToEpochUs(DateTime dateTime) =>
      dateTime?.microsecondsSinceEpoch;

}
