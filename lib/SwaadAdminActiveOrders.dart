import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/styles.dart';
import 'package:swaadv2/OrderDetails.dart';
import 'package:swaadv2/MyDrawer.dart';

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
        .collection('swaadOrders')
        .where('status', whereIn: ['PLACED', 'PAY_PENDING', 'MAKING', 'READY'])
        .orderBy('deliveryTime', descending: true)
        .snapshots();
    super.initState();
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
      return ListTile(
        selected: true,
        leading: Icon(
          Icons.fastfood,
          color: Colors.amber,
        ),
        title: Text('Order# ' + document['orderId'],
          style: Styles.productRowItemName,
        ),
        subtitle: Text('Ordered By: ' + document['orderBy'] +
            '\n Pickup Time: ' +
            DateTime.fromMicrosecondsSinceEpoch(document['deliveryTime'])
                .toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(document['status']),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (_) => OrderDetails(widget.phoneNum, document)),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Action required on..")),
      drawer: MyDrawer(widget.phoneNum),
      persistentFooterButtons: <Widget>[
        new IconButton(
          icon: new Icon(Icons.refresh),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => SwaadAdminActiveOrders(widget.phoneNum)),
          ),
        ),
        new IconButton(
          icon: new Icon(Icons.home),
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
