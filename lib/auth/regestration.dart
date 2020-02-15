import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Regestration extends StatefulWidget {
  @override
  _RegestrationState createState() => _RegestrationState();
}

class _RegestrationState extends State<Regestration> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor regestration.'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Enter Name'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      onSaved: (val) => print(val),
                    )
                  ],
                ),
            ),
        ),
      ),
    );
  }
}
