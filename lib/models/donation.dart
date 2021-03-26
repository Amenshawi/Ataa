// We should make a donation object to pass rather then
// passing every cariable separtly

import 'dart:io';
import 'package:Ataa/models/app_user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Donation {
  final String type;
  final AppUser user;
  final File image;
  final String imageURL;
  final String desc;
  final bool anonymous;
  final LatLng location;
  DateTime timeStamp;
  final DateTime notifyAt;
  String status;
  final String did; // donation  id
  Donation(
      {this.type,
      this.user,
      this.image,
      this.imageURL,
      this.desc,
      this.anonymous,
      this.location,
      this.notifyAt,
      this.timeStamp,
      this.status,
      this.did}) {
    if (this.timeStamp == null) this.timeStamp = DateTime.now();
  }
}
