import 'dart:typed_data';
import 'package:Ataa/Custom/Sheet.dart';
import 'package:Ataa/models/CustomMarker.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/screens/charity/report_stand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, 1);

class LocationView extends StatefulWidget {
  Set<CustomMarker> customMarkers;
  final bool report;

  LocationView(this.report, {this.customMarkers});
  @override
  _LocationViewState createState() =>
      _LocationViewState(this.report, customMarkers: customMarkers);
}

class _LocationViewState extends State<LocationView> {
  AppUser user;
  var changeLocation;
  String addressLine = '';
  LatLng currentPosition = LatLng(37.4219983, -122.084);
  bool foundLocation = false;
  GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<CustomMarker> customMarkers = {};
  bool once = false;
  final bool report;

  Position location = Position();
  /*Location location = new Location();
  LocationData _locationData;*/
  @override
  initState() {
    super.initState();
    if (markers == null) markers = {};
  }

  TextEditingController addressController = TextEditingController();

  _LocationViewState(this.report, {this.customMarkers});
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);
    if (!once) _getUserLocation();
    _addMarkers(customMarkers);

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      foundLocation
          ? Expanded(
              child: Stack(children: [
                GoogleMap(
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: markers,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      zoom: 16),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 00,
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                              prefixIcon:
                                  Icon(Icons.location_pin, color: ataaGreen),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ))
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: MediaQuery.of(context).size.width * 0.33,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.grey,
                          color: Colors.grey[400],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              heightFactor: 3,
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ataaGreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.grey,
                          color: Color.fromRGBO(28, 102, 74, 1),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.17,
                  right: 15,
                  height: 50,
                  width: 50,
                  child: RawMaterialButton(
                    highlightColor: ataaGold,
                    elevation: 100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.add_circle,
                      color: ataaGreen,
                      size: 50,
                    ),
                    onPressed: () {
                      _currentLocation();
                    },
                  ),
                ),
              ]),
            )
          : Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.height * .2,
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(244, 234, 146, 1),
                      valueColor: AlwaysStoppedAnimation(
                          Color.fromRGBO(28, 102, 74, 1)),
                    ),
                  ),
                ),
              ),
            ),
    ]);
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

  void _onCameraMove(CameraPosition camera) {
    setState(() {
      currentPosition = LatLng(camera.target.latitude, camera.target.longitude);
    });
  }

  _addMarkers(Set<CustomMarker> customMarkers) {
    Uint8List icon;
    customMarkers.forEach((customMarker) async {
      if (customMarker.type == 'fridge') {
        icon = await getBytesFromAsset('assets/Images/food.png', 150);
      } else if (customMarker.type == 'water') {
        icon = await getBytesFromAsset('assets/Images/water-tap.png', 150);
      } else {
        icon = await getBytesFromAsset('assets/Images/clothes.png', 150);
      }
      var marker = Marker(
          markerId: customMarker.marker.markerId,
          position: customMarker.marker.position,
          icon: BitmapDescriptor.fromBytes(icon),
          onTap: () async {
            if (report) {
              showSheet(context, 'Report a Stand',
                  ReportStandSheet(customMarker.marker.markerId.value), false);
            } else {
              Coordinates coordinates = new Coordinates(
                  currentPosition.latitude, currentPosition.longitude);
              var addresses = await Geocoder.local
                  .findAddressesFromCoordinates(coordinates);
              var first = addresses.first;
              String temp = first.addressLine;

              setState(() {
                addressController.text = temp;
                addressLine = temp;
              });
            }
          });
      markers.add(marker);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  showSheet(context, sheetName, content, padding) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 100,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Sheet(
            sheetName: sheetName,
            content: content,
            padding: padding,
          );
        }).whenComplete(() {
      Navigator.pop(context);
    });
  }
}
