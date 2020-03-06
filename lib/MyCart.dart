import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/models/CartService.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/models/MenuModels.dart';
import 'package:swaadv2/styles.dart';
import 'package:swaadv2/Confirmation.dart';

const double _kDateTimePickerHeight = 216;

class MyCart extends StatefulWidget {
  final CartService cartService;

  const MyCart(this.cartService);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  DateTime selectedDateTime;
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '₹');

  var id = UniqueKey();
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
  };

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  //color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Pickup time',
                  //style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              //style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shopping Cart"),
        ),
        persistentFooterButtons: <Widget>[
          new IconButton(
            icon: new Icon(Icons.home),
            alignment: Alignment.center,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                  builder: (_) => OrderingMenu(widget.cartService.phoneNumber)),
            ),
          ),
        ],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(),
              ),
            ) // Place sliver widgets here
          ],
        ),
      ),
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index - 4;
        switch (index) {
          case 0:
            return Container();
          case 1:
            return Container();
          case 2:
            return Container();
          case 3:
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: _buildDateAndTimePicker(context),
            );
          default:
            if (widget.cartService.selectedItems.length > productIndex) {
              return ShoppingCartItem(
                index: index,
                product: widget.cartService.selectedItems[productIndex].item,
                quantity: widget
                    .cartService.selectedItems[productIndex].quantity
                    .toInt(),
                lastItem:
                    productIndex == widget.cartService.selectedItems.length - 1,
                formatter: _currencyFormat,
              );
            } else if (widget.cartService.selectedItems.length ==
                    productIndex &&
                widget.cartService.selectedItems.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Shipping '
                            '${_currencyFormat.format(widget.cartService.shippingCost)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tax ${_currencyFormat.format(widget.cartService.tax)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Total  ${_currencyFormat.format(widget.cartService.totalCost)}',
                            style: Styles.productRowTotal,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          saveOrderDetails();
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (_) => OrderingMenu(
                                  widget.cartService.phoneNumber)));
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ]),
              );
            }
        }
        return null;
      },
    );
  }

  void saveOrderDetails() async {
    SwaadOrder swaadOrder = new SwaadOrder();
    swaadOrder.deliveryTime = dateTime;
    swaadOrder.orderReceivedDate = new DateTime.now();
    swaadOrder.orderId = UniqueKey().hashCode.toString();
    swaadOrder.orderType = 'PICKUP';
    swaadOrder.orderBy = widget.cartService.phoneNumber;
    swaadOrder.status = 'PLACED';
    swaadOrder.items = widget.cartService.selectedItems;
    String sorder = jsonEncode(swaadOrder);

    //DocumentReference ds =
    await Firestore.instance
        .collection('swaadOrders')
        .document(swaadOrder.orderId)
        .setData(jsonDecode(sorder))
        .whenComplete(() =>  {
      Text("Added swaad order : " + swaadOrder.orderId),
      setState(
        () => widget.cartService.selectedItems.clear(),
      ),
      Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (_) => Confirmation(
                widget.cartService.phoneNumber, swaadOrder.orderId)),
      ),
    });
    return;
  }
}

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    @required this.index,
    @required this.product,
    @required this.lastItem,
    @required this.quantity,
    @required this.formatter,
  });

  final MenuItem product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.itemName,
                          style: Styles.productRowItemName,
                        ),
                        Text(
                          '${formatter.format(quantity * product.price)}',
                          style: Styles.productRowItemName,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${quantity > 1 ? '$quantity x ' : ''}'
                      '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return row;
  }
}
