import 'package:flutter/material.dart';
import 'package:swaadv2/MyCart.dart';
import 'package:swaadv2/models/CartService.dart';

class SaveDataError extends StatelessWidget {
  final CartService cartService;
  final String orderId;

  SaveDataError(this.cartService, this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Failed to persist order details'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Text(
                'Failed to persist your order # ' + orderId,
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () => MyCart(cartService),
                child: Text(
                  'Please try again!!',
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
