import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _logo(context),
          _middleImageSlider(context),
          _signInSection(context),
          _goBack(context),
        ],
      ),
    );
  }
}

Widget _logo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueAccent,
    ),
    child: Center(
      child: RaisedButton(
        color: Colors.teal,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    ),
  );
}

Widget _middleImageSlider(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueAccent,
    ),
    child: Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    ),
  );
}

Widget _signInSection(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white70,
    ),
    child: Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('SignIn!'),
      ),
    ),
  );
}

Widget _goBack(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueAccent,
    ),
    child: Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go Back!'),
      ),
    ),
  );
}