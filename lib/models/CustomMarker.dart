import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  Marker marker;
  String type;
  Icon icon;
  String title;
  String snippet;

  CustomMarker({this.marker, this.type, this.icon, this.title, this.snippet});
}
