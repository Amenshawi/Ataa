import 'package:Ataa/appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';

class Database {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addUser(String uid, String fname, String lname, DateTime bday) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.add({
      'uid': uid,
      'first_name': fname,
      'last_name': lname,
      'birthdate': bday,
      'type': 'reciever'
    }).then((value) {
      print("User Added");
      final user = AppUser(uid: uid, fname: fname, lname: lname);
      return user;
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future fetchUserData(String uid) async {
    firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      final user = AppUser(
          uid: uid,
          fname: value.docs.first.data()['first_name'],
          lname: value.docs.first.data()['last_name']);
      print('user Data fetched successfully !');
      return user;
    }).catchError((error) => print("Failed to fetch user data: $error"));
  }

  searchForCharity(String name) async {
    var result = await firestore
        .collection('charities')
        .orderBy('name')
        .startAt([name])
        .endAt([name + '\uf8ff'])
        .get()
        .then((snapshot) {
          for (var i = 0; i < snapshot.docs.length; i++) {
            print(snapshot.docs[i].data()['name']);
          }
          return snapshot.docs;
        })
        .catchError((error) => print("Failed to search for charities: $error"));
    return result;
  }
}
