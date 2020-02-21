import 'package:flutter/material.dart';
import 'package:swaadv2/models/CartService.dart';

class MyCart extends StatefulWidget {
  final CartService cartService;
  const MyCart(this.cartService);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Items'),),
      body: Container(
        child: Text('In cart'+ widget.cartService.productsInCart.length.toString()),
      ),
    );
  }
}
