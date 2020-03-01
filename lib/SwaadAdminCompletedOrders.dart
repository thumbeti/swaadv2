import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/styles.dart';

class SwaadAdminCompletedOrders extends StatelessWidget {
  final String phoneNum;

  SwaadAdminCompletedOrders(this.phoneNum);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> itemStream = Firestore.instance
        .collection('swaadOrders')
        .where('status', isEqualTo:"DONE")
        .orderBy('deliveryTime', descending: true)
        .snapshots();
    return Scaffold(
      appBar: AppBar(title: Text("Completed Orders")),
      persistentFooterButtons: <Widget>[
        new IconButton(
          icon: new Icon(Icons.home),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => OrderingMenu(phoneNum)),
          ),
        ),
      ],
      body: StreamBuilder(
        stream: itemStream,
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading..");
          }
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildList(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.amber,
      ),
      title: Text("Order# " +
          document['orderId'],
        style: Styles.productRowItemName,
      ),
      subtitle: Text("PickupTime: \n" +
          DateTime.fromMicrosecondsSinceEpoch(document['deliveryTime']).toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(document['status']),
        ],
      ),
    );
  }
}
