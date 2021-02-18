import 'dart:ui';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng currentPosition = LatLng(37.4219983 , -122.084);
  bool foundLocation = true;
  GoogleMapController mapController;

  bool once = true;

  @override
  Widget build(BuildContext context) {
    if(!once)
    _getUserLocation();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: foundLocation ?
        GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: currentPosition, zoom: 5),
        )
        :Center(child: Text('loading'),)
    );
  }
  Future _getUserLocation() async {
    print('asking permission');
     Map<Permission, PermissionStatus> statuses = await [
      Permission.location,].request();
        var position = await GeolocatorPlatform.instance
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        if(statuses[Permission.location].isGranted)
        setState(() {
          currentPosition = LatLng(position.latitude, position.longitude);
          foundLocation = true;
          once = true;
        });
        print("lat " + currentPosition.latitude.toString() + " log " + currentPosition.longitude.toString());
        print(' done loading');
  }
   void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}