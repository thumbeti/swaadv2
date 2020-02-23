import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swaadv2/MyCart.dart';
import 'package:swaadv2/firestoreservices/firestoreservice.dart';
import 'package:swaadv2/models/CartService.dart';
import 'dart:async';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/models/SwaadOrder.dart';

class OrderingMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MenuPage createState() => new _MenuPage();
}

//State is information of the application that can change over time or when some actions are taken.
class _MenuPage extends State<MyApp> {
  String _value = '';

  //List<CartMenuItem> cartItems = new List<CartMenuItem>(50);
  CartService cartService = new CartService();

  void _onClick(String value) => setState(() => _value = value);

  List<MenuItem> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> menuItems;

  Stream<QuerySnapshot> itemStream;

  @override
  void initState() {
    itemStream = Firestore.instance
        .collection('menuItems')
        .where('itemOwner', isEqualTo: 'Swaad')
        .snapshots();
    cartService.setAllItems(itemStream);
    super.initState();
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.amber,
      ),
      title: Text(document['itemName']),
      subtitle: Text(document['description']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          (cartService.getSelectedItemQuantity(
                      MenuItem.fromJson(document.data)) !=
                  -1)
              ? new IconButton(
                  icon: new Icon(Icons.remove),
                  onPressed: () => setState(
                    () => cartService
                        .removeItemFromCart(MenuItem.fromJson(document.data)),
                  ),
                )
              : new Container(),
          (cartService.getSelectedItemQuantity(
                      MenuItem.fromJson(document.data)) !=
                  -1)
              ? new Text(cartService
                  .getSelectedItemQuantity(MenuItem.fromJson(document.data))
                  .toString())
              : new Text('ADD'),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => setState(
                    () => cartService
                        .addProductToCart(MenuItem.fromJson(document.data)),
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
            MaterialPageRoute<void>(builder: (_) => MyCart(cartService)),
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
