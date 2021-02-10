import 'package:Ataa/appUser.dart';
import 'package:Ataa/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/semantics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future addUser(String uid, String fname, String lname, DateTime bday) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.add({
      'uid': uid,
      'first_name': fname,
      'last_name': lname,
      'birthdate': bday,
      'type': 'Donor'
    }).then((value) {
      print("User Added");
      return true;
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future fetchUserData(User fUser) async {
    return await firestore
        .collection('users')
        .where('uid', isEqualTo: fUser.uid)
        .get()
        .then((value) {
      final user = AppUser(
          uid: fUser.uid,
          email: fUser.email,
          fname: value.docs.first.data()['first_name'],
          lname: value.docs.first.data()['last_name']);
      print('user Data fetched successfully !');
      print(user);
      return user;
    }).catchError((error) => print("Failed to fetch user data: $error"));
  }

  Future searchForCharity(String name) async {
    final result = await firestore
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

  Future changePrivacy(AppUser user, bool changTo) async {
    final doc = await firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await firestore
          .collection('users')
          .doc(value.docs[0].id)
          .set({'private': changTo});
      return true;
    }).catchError((error) => {
              //do something when an error happens
            });
  }

  Future<bool> getPrivacy(AppUser user) async {
    print('getting privacy');
    final doc = await firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) {
      return value.docs[0].data();
    });
    print(doc['private']);
    if (doc['private'] == true) {
      print('returning true');
      return true;
    } else {
      print('returning false');
      return false;
    }
  }
}
