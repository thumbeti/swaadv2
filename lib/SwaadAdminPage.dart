import 'package:flutter/material.dart';
import 'package:swaadv2/SwaadAdminActiveOrders.dart';
import 'package:swaadv2/SwaadAdminCompletedOrders.dart';

class SwaadAdminPage extends StatefulWidget {
  final String phoneNum;
  SwaadAdminPage(this.phoneNum);

  @override
  _SwaadAdminPageState createState() => _SwaadAdminPageState();
}

class _SwaadAdminPageState extends State<SwaadAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          RaisedButton(
              child: Text('Action Required'),
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (_) =>
                              SwaadAdminActiveOrders(widget.phoneNum)),
                    ),
                  }),
          RaisedButton(
            child: Text('Completed Orders'),
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => SwaadAdminCompletedOrders(widget.phoneNum)),
              )
            },
          ),
        ]),
      ),
    );
  }
}
