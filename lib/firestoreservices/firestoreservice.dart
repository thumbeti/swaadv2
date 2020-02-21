import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swaadv2/models/menuItem.dart';

/*
final CollectionReference menuCollection =
    Firestore.instance.collection('menuItems').where('itemOwner', isEqualTo:'Swaad');
*/
final CollectionReference menuCollection = Firestore.instance.collection('menuItems');

class FirestoreService {
  Stream<QuerySnapshot> getMenuItems({int offset, int limit}) {
    //CollectionReference menuCollection = Firestore.instance.collection('menuItems');
    Stream<QuerySnapshot> snapshots = menuCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
