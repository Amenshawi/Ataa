import 'package:Ataa/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';

class Database {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Database();

  Future addUser(String uid, String fname, String lname, DateTime bday) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .add({
          'uid': uid,
          'first_name': fname,
          'last_name': lname,
          'birthdate': bday,
          'type': 'reciever'
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
