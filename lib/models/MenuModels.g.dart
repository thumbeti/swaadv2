// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map json) {
  return MenuItem(
    (json['id'] as num)?.toDouble(),
    json['itemName'] as String,
    json['itemOwner'] as String,
    (json['minQuantity'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
    json['image'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'itemName': instance.itemName,
      'itemOwner': instance.itemOwner,
      'minQuantity': instance.minQuantity,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
    };

SelectedItem _$SelectedItemFromJson(Map json) {
  return SelectedItem(
    json['item'],
    (json['quantity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SelectedItemToJson(SelectedItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
    };

SwaadOrder _$SwaadOrderFromJson(Map json) {
  return SwaadOrder()
    ..deliveryTime =
        SwaadOrder._dateTimeFromEpochUs(json['deliveryTime'] as int)
    ..orderReceivedDate =
        SwaadOrder._dateTimeFromEpochUs(json['orderReceivedDate'] as int)
    ..orderId = json['orderId'] as String
    ..orderType = json['orderType'] as String
    ..orderBy = json['orderBy'] as String
    ..status = json['status'] as String
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : SelectedItem.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList();
}

Map<String, dynamic> _$SwaadOrderToJson(SwaadOrder instance) =>
    <String, dynamic>{
      'deliveryTime': SwaadOrder._dateTimeToEpochUs(instance.deliveryTime),
      'orderReceivedDate':
          SwaadOrder._dateTimeToEpochUs(instance.orderReceivedDate),
      'orderId': instance.orderId,
      'orderType': instance.orderType,
      'orderBy': instance.orderBy,
      'status': instance.status,
      'items': instance.items,
    };
