import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swaadv2/SwaadAdminActiveOrders.dart';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/SelectedItemsPage.dart';

class OrderDetails extends StatefulWidget {
  final String phoneNum;
  final DocumentSnapshot ds;

  OrderDetails(this.phoneNum, this.ds);
  String newStatus = null;
  SwaadOrder swaadOrder;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.swaadOrder = SwaadOrder.fromJson(widget.ds.data);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Order# ' + widget.ds['orderId']),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Text(
                'Order # ' + widget.ds['orderId'],
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              Text(
                'Ordered By : ' + widget.ds['orderBy'],
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              Text(
                'Order pickup time : ' +
                    DateTime.fromMicrosecondsSinceEpoch(
                            widget.ds['deliveryTime'])
                        .toString(),
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => SelectedItemsPage(widget.swaadOrder)));
                },
                child: Text(
                  'Selected Items and Quantity',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Current status : ' + widget.ds['status'],
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              buildDropdownButton(),
              RaisedButton(
                onPressed: () {
                  updateSwaadOrder();
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => SwaadAdminActiveOrders(widget.phoneNum)));
                },
                child: Text(
                  'Update Status!!',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSwaadOrder() {
    try {
      final databaseReference = Firestore.instance;
      databaseReference.collection('swaadOrders')
          .document(widget.ds.documentID)
          .updateData({'status': widget.newStatus});
    } catch (e) {
      print(e.toString());
    }
  }
  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      hint: Text(
        'Select new status',
        style: TextStyle(fontSize: 25.0),
      ),
      value: widget.newStatus,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          widget.newStatus = newValue;
        });
      },
      items: <String>[
        'PLACED',
        'PAY_PENDING',
        'MAKING',
        'READY',
        'DONE',
        'CANCEL'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
