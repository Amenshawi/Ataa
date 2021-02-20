import 'dart:ui';
import 'package:Ataa/appUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/database.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:geolocator/geolocator.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, 1);

class LocationPage extends StatefulWidget {
  final AppUser user;
  final changeLocation;

  LocationPage(this.user, this.changeLocation);
  @override
  _LocationPageState createState() => _LocationPageState(user, changeLocation);
}

class _LocationPageState extends State<LocationPage> {
  AppUser user;
  final database = Database();
  var changeLocation;
  String addressLine = '';
  LatLng currentPosition = LatLng(37.4219983, -122.084);
  bool foundLocation = false;
  GoogleMapController mapController;
  Set<Marker> marker = {};

  bool once = false;

  Position location = Position();
  /*Location location = new Location();
  LocationData _locationData;*/

  TextEditingController addressController = TextEditingController();

  _LocationPageState(this.user, this.changeLocation);
  @override
  Widget build(BuildContext context) {
    if (!once) _getUserLocation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ataaGreen,
        title: Text('Your Location',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
      ),
      body: Stack(children: [
        foundLocation
            ? GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
                markers: marker,
                onMapCreated: _onMapCreated,
                onCameraMove: _onCameraMove,
                onCameraIdle: _onCameraIdle,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentPosition.latitude, currentPosition.longitude),
                    zoom: 16),
              )
            : Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.height * .2,
                  child: CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(244, 234, 146, 1),
                    valueColor:
                        AlwaysStoppedAnimation(Color.fromRGBO(28, 102, 74, 1)),
                  ),
                ),
              ),
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width * 00,
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: ataaGreen, width: 3)),
                  elevation: 30,
                  color: Colors.white,
                  child: TextField(
                    maxLines: 2,
                    controller: addressController,
                    style: TextStyle(
                        color: ataaGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: ataaGreen),
                        onPressed: (){
                          _findLocationFromAddress();
                        },
                      ),
                      prefixIcon: Icon(Icons.location_pin, color: ataaGreen),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ))
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.grey,
            color: Color.fromRGBO(28, 102, 74, 1),
            child: GestureDetector(
              onTap: () {
                if (changeLocation == null) {
                  database
                      .addLocation(addressLine, currentPosition, user)
                      .whenComplete(() {
                    Navigator.pop(context);
                  });
                } else {
                  changeLocation(currentPosition);
                  Navigator.pop(context);
                }
              },
              child: Center(
                heightFactor: 3,
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(244, 234, 146, 1)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.1,
          right: 25,
          height: 50,
          width: 50,
          child: RawMaterialButton(
            highlightColor: ataaGold,
            elevation: 100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.white,
            child: Icon(
              Icons.add_circle, 
              color: ataaGreen,
              size: 50,),
            onPressed: (){
              _currentLocation();
            },
          ),
        ),
      ]),
    );
  }

  Future _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    var temp = await Geolocator.getCurrentPosition();
    setState(() {
      location = temp;
      once = true;
      currentPosition = LatLng(temp.latitude, temp.longitude);
      foundLocation = true;
    });

    /*bool status = await location.serviceEnabled();
    PermissionStatus _permissionGranted;
    if (!status) {
      status = await location.requestService();
      if (!status) return;
    }
    _permissionGranted = await location.hasPermission();
    print(_permissionGranted);
    if (_permissionGranted == PermissionStatus.denied) {
      print(_permissionGranted);
      _permissionGranted = await location.requestPermission();
      print(_permissionGranted);
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print('before get location');
    var temp = await location.getLocation();
    print('after get location');
    print(temp);
    setState(() {
      _locationData = temp;
      foundLocation = true;
      once = true;
      currentPosition = LatLng(
        _locationData.latitude, 
        _locationData.longitude);
    });*/
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    setState(() {
      marker.add(
          Marker(markerId: MarkerId('address'), position: currentPosition));
      print(" current marker position " + currentPosition.toString());
    });
  }

  void _onCameraMove(CameraPosition camera) {
    setState(() {
      currentPosition = LatLng(camera.target.latitude, camera.target.longitude);
      marker.remove(Marker);
      marker.add(
          Marker(markerId: MarkerId('address'), position: currentPosition));
    });
  }

  void _onCameraIdle() async {
    Coordinates coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String temp = first.addressLine;

    setState(() {
      addressController.text = temp;
      addressLine = temp;
    });
  }
  void _currentLocation() async {
    LocationPermission permission;

   if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    var temp = await Geolocator.getCurrentPosition();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(temp.latitude, temp.longitude),
        zoom: 16.0,
      ),
    ));
  }
  void _findLocationFromAddress() async{
    var result = await Geocoder.local.findAddressesFromQuery(addressController.text);
    var first = result.first;
     mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(
          first.coordinates.latitude, 
          first.coordinates.longitude
          ),
        zoom: 16.0,
      ),
    ));
  }
}
