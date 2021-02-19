import 'dart:io';
import 'dart:math';

import 'package:Ataa/appUser.dart';
import 'package:Ataa/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future addUser(String uid, String fname, String lname, DateTime bday) async {
    CollectionReference users = firestore.collection('users');

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
          lname: value.docs.first.data()['last_name'],
          shirtSize: value.docs.first.data()['shirtSize'],
          pantSize: value.docs.first.data()['pantsSize'],
          shoeSize: value.docs.first.data()['shoeSize']);
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
          .update({'private': changTo});
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

  Future updateClothesSizes(
      String shirtSize, String pantsSize, int shoeSize, AppUser user) async {
    print('hi');
    return await firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await firestore.collection('users').doc(value.docs[0].id).update({
        'shirtSize': shirtSize,
        'pantsSize': pantsSize,
        'shoeSize': shoeSize
      });
      return true;
    }).catchError((error) => {
              print(error.toString)
              //do something when an error happens
            });
  }

  Future addDonation(AppUser user, String type, image, String desc,
      bool anonymous, location) async {
    image = File(image.path);
    final url = await uploadImage(image);
    final ref = await firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) {
      return value.docs[0].reference;
    });
    await firestore.collection('donations').add({
      'type': type,
      'user': ref,
      'image': url,
      'desc': desc,
      'anonymous': anonymous,
      'location': location
    }).then((value) {
      print('donation added');
      return;
    }).catchError((error) {
      print('couldn\'t add donation.\nError: ' + error.toString());
      return error;
    });
  }

  Future<String> uploadImage(File _image) async {
    final rn = new Random().nextInt(99999);

    String url;
    Reference ref = firebaseStorage
        .ref()
        .child('donations/D' + DateTime.now().toString() + rn.toString());
    UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      print('File Uploaded');
    }).catchError((error) {
      print('couldn\'t upload image');
      print(error.toString());
    });

    return url;
  }
}
