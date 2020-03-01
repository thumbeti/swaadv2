import 'package:flutter/material.dart';
import 'package:swaadv2/OrderingMenu.dart';
import 'package:swaadv2/VendorSwaadOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/SwaadAdminPage.dart';

class MyDrawer extends StatelessWidget {
  final String phoneNum;
  MyDrawer(this.phoneNum);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        //padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 30.0),
          ListTile(
            title: Text(
              'Swaad Menu',
              style: TextStyle(fontSize: 15.0),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => OrderingMenu(phoneNum)));
            },
          ),
          ListTile(
            title: Text(
              'Your Orders',
              style: TextStyle(fontSize: 15.0),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => VendorSwaadOrders(phoneNum)));
            },
          ),
          ListTile(
            title: Text(
              'Swaad Orders',
              style: TextStyle(fontSize: 15.0),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => SwaadAdminPage(phoneNum)));
            },
          ),
        ],
      ),
    );
  }

/*
  Future<Widget> swaadAdminLink(BuildContext context) async {
    DocumentReference qs = Firestore.instance.collection('users').document(phoneNum).
    DocumentSnapshot snap = await qs.get();
    if (snap.data == null) {
      print('User does not exist.');
      return Container();
    } else {
      if(snap.data['userType'].toString().compareTo('SWAAD_ADMIN') == 0) {
        print('Current user is SWAAD admin' + phoneNum);
        return ListTile(
          title: Text(
            'Swaad Orders',
            style: TextStyle(fontSize: 15.0),
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (_) => SwaadAdminPage(phoneNum)));
          },
        )
      } else {
        print('Current user is not admin' + phoneNum);
        return Container();
      }
    }
  }
 */
}
