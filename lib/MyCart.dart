import 'package:flutter/material.dart';
import 'package:swaadv2/models/CartService.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCart extends StatefulWidget {
  final CartService cartService;
  const MyCart(this.cartService);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  DateTime selectedDateTime;

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
  };

  Widget _dateTimeSelecion() {
    return ListView(
      children: <Widget>[
        DateTimePickerFormField(
          inputType: InputType.both,
          format: formats[InputType.both],
          editable: false,
          initialDate: DateTime.now(),
          initialTime: TimeOfDay.now(),
          selectableDayPredicate: (DateTime val) =>
          (val.day < DateTime.now().day) ? false : true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Requesting pickup Date/Time', hasFloatingPlaceholder: false),
          onChanged: (dt) => setState(() => selectedDateTime = dt),
        ),
        Text('Date value: $selectedDateTime'),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.amber,
      ),
      title: Text(document['itemName']),
      subtitle: Text(document['itemOwner']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text('ADD'),
        ],
      ),
    );
  }

  Widget _selectedItems() {
    return StreamBuilder(
      stream: Firestore.instance.collection('menuItems').where(
          'itemOwner', isEqualTo: 'Swaad').snapshots(),
      //print an integer every 2secs, 10 times
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading..");
        }
        return ListView.builder(
          itemExtent: 80.0,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            //if (widget.cartService.productsInCart.containsKey())
            return _buildList(context, snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  /*
  Widget _selectedItems_2() {
    return StreamBuilder(
      stream: Firestore.instance.collection('menuItems').where('itemOwner', isEqualTo: 'Swaad').snapshots(),
      //print an integer every 2secs, 10 times
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading..");
        }
        return ListView.builder(
          itemExtent: 80.0,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            if(widget.cartService.productsInCart.containsKey())
            return _buildList(context, snapshot.data.documents[index]);
          },
        );
      },
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Items'),
      ),
      body: Container(
          //child: _dateTimeSelecion(),
          child: _selectedItems(),
      ),
      );
  }
}
