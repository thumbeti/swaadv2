// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedItem _$SelectedItemFromJson(Map<String, dynamic> json) {
  return SelectedItem(
    json['item'],
    json['quantity'] as int,
  );
}

Map<String, dynamic> _$SelectedItemToJson(SelectedItem instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
    json['id'] as int,
    json['itemName'] as String,
    json['itemOwner'] as String,
    json['minQuantity'] as int,
    json['price'] as int,
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
