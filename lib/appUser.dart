import 'package:flutter/material.dart';

class AppUser {
  final String uid;
  String email;
  final String fname;
  final String lname;
  String shirtSize;
  String pantSize;
  int shoeSize;
  AppUser({@required this.uid, @required this.email, this.fname, this.lname, this.shirtSize, this.pantSize, this.shoeSize});
}
