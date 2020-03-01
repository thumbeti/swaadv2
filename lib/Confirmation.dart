import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swaadv2/VendorSwaadOrders.dart';

class Confirmation extends StatelessWidget {
  final String phoneNumber;
  final String OrderId;

  Confirmation(this.phoneNumber, this.OrderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your order details'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Text(
                'Your order # ' + OrderId,
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              Text(
                'Swaad Living will contact you shortly on payment.',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => VendorSwaadOrders(phoneNumber)));
                },
                child: Text(
                  'Track your orders!!',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
