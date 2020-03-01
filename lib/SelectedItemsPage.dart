import 'package:flutter/material.dart';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/styles.dart';

class SelectedItemsPage extends StatelessWidget {
  final SwaadOrder swaadOrder;

  SelectedItemsPage(this.swaadOrder);

  Widget _buildList(BuildContext context, SelectedItem sItem) {
    return ListTile(
      selected: true,
      leading: Icon(
        Icons.fastfood,
        color: Colors.amber,
      ),
      title: Text( 'Item Name : ' +  sItem.item.itemName,
        style: Styles.productRowItemName,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(sItem.quantity.toString()),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Menu Items')),
      body: ListView.builder(
        itemExtent: 80.0,
        itemCount: swaadOrder.items.length,
        itemBuilder: (context, index) {
          return _buildList(context, swaadOrder.items[index]);
        },
      ),
    );
  }
}
