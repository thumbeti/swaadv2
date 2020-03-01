import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/styles.dart';

class SwaadAdminActiveOrders extends StatefulWidget {
  final String phoneNum;

  SwaadAdminActiveOrders(this.phoneNum);

  @override
  _SwaadAdminActiveOrdersState createState() => _SwaadAdminActiveOrdersState();
}

class _SwaadAdminActiveOrdersState extends State<SwaadAdminActiveOrders> {
  List<SwaadOrder> sOrders;
  Stream<QuerySnapshot> itemStream;

  @override
  void initState() {
    itemStream = Firestore.instance
        .collection('menuItems')
        .where('itemOwner', isEqualTo: 'Swaad')
        .snapshots();
    super.initState();
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.amber,
      ),
      title: Text(
        document['itemName'],
        style: Styles.productRowItemName,
      ),
      subtitle: Text(document['description']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.remove),
            onPressed: () => setState(
                  () => new Text("Previous State"),
            ),
          ),
          new Text("Status"),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => setState(
                    () => new Text("Next state"),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swaad Menu Items")),
      persistentFooterButtons: <Widget>[
        new IconButton(
          icon: new Icon(Icons.add_shopping_cart),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => OrderingMenu(widget.phoneNum)),
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
}
