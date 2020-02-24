// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwaadOrder _$SwaadOrderFromJson(Map<String, dynamic> json) {
  return SwaadOrder(
    SwaadOrder._dateTimeFromEpochUs(json['deliveryTime'] as int),
    SwaadOrder._dateTimeFromEpochUs(json['orderReceivedDate'] as int),
    json['orderType'] as String,
    json['orderBy'] as String,
    json['status'] as String,
    (json['items'] as List)
        ?.map((e) =>
            e == null ? null : SelectedItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SwaadOrderToJson(SwaadOrder instance) =>
    <String, dynamic>{
      'deliveryTime': SwaadOrder._dateTimeToEpochUs(instance.deliveryTime),
      'orderReceivedDate':
          SwaadOrder._dateTimeToEpochUs(instance.orderReceivedDate),
      'orderType': instance.orderType,
      'orderBy': instance.orderBy,
      'status': instance.status,
      'items': instance.items,
    };

SelectedItem _$SelectedItemFromJson(Map<String, dynamic> json) {
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

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
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
