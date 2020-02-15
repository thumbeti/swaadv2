import 'package:flutter/material.dart';
import 'package:swaadv2/Intro.dart';
import 'package:swaadv2/auth/authentication.dart';
import 'package:swaadv2/auth/phoneAuthV2.dart';
//void main() => runApp(MyApp());

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Intro!!'),
              onPressed: () => _pushPage(context, Intro()),
            ),
            RaisedButton(
              child: Text('PhoneSignIn Working'),
              onPressed: () => _pushPage(context, SignInPage()),
            ),
            RaisedButton(
              child: Text('PhoneSignIn V2'),
              onPressed: () => _pushPage(context, PhoneAuth()),
            ),
          ],
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
