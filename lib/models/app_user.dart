import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppUser {
  final String uid;
  String email;
  final String fname;
  final String lname;
  String shirtSize = '';
  String pantSize= '';
  int shoeSize = 0;
  String addressLine = '';
  GeoPoint location;
  bool privacy = false;
  AppUser({@required this.uid, @required this.email,
   this.fname, this.lname, 
   this.shirtSize, this.pantSize, this.shoeSize,
   this.addressLine,this.location, this.privacy});

   LatLng getLocation(){
     if(this.location != null){
      LatLng temp = LatLng(this.location.latitude, this.location.longitude);
      return temp;
     }else
      return null;
   }
   void setShoeSize(int size){
     this.shoeSize = size;
   }
}
