import 'package:flutter/material.dart';
import 'dart:async';

class OrderingMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OrderingMenu"),
      ),
      body: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyApp>{

  String _value = '';
  void _onClick(String value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('items')
            ],
          ),
        ),
      ),
    );
  }
}