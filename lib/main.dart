import 'package:flutter/material.dart';
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
    return PhoneAuth();
  }
}
