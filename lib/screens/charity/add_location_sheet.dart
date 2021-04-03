import 'package:Ataa/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import '../location_page.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);

class AddLocationSheet extends StatefulWidget {
  @override
  _AddLocationSheetState createState() => _AddLocationSheetState();
}

class _AddLocationSheetState extends State<AddLocationSheet> {
  double hieghtSize, widthSize;
  bool private = false;
  LatLng location;

  void _changeLocation(LatLng _location) {
    setState(() {
      this.location = _location;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return addLocation();
  }

  Widget addLocation() {
    return Container(
      width: widthSize,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: hieghtSize * 0.04, bottom: hieghtSize * 0.04),
          child: Column(
            children: [
              SizedBox(height: hieghtSize * 0.01),
              Container(
                height: hieghtSize * 0.2,
                width: widthSize,
                child: Card(
                  color: ataaWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationPage(
                                        Provider.of<AppUser>(context),
                                        _changeLocation)));
                          }),
                          readOnly: true,
                          cursorColor: ataaGreen,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ataaGreen)),
                              prefixIcon: Icon(
                                Icons.location_on,
                                size: 25,
                                color: ataaGreen,
                              ),
                              hintText: 'Location..',
                              hintStyle:
                                  TextStyle(color: ataaGreen, fontSize: 20)),
                        ),
                      ),
                      Container(
                          height: hieghtSize * 0.14,
                          child: location != null
                              ? GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                  target: location,
                                  zoom: 16.0,
                                ))
                              : Center(
                                  child: Text(
                                    'no Location selcted',
                                    style: TextStyle(
                                        fontSize: 18, color: ataaGreen),
                                  ),
                                ))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                color: ataaWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    TextField(
                      readOnly: true,
                      cursorColor: ataaGreen,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ataaGreen)),
                          prefixIcon: Icon(
                            Icons.comment,
                            size: 25,
                            color: ataaGreen,
                          ),
                          hintText: 'Comments..',
                          hintStyle: TextStyle(color: ataaGreen, fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: TextField(
                        style: TextStyle(
                            color: ataaGreen,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                        cursorColor: ataaGreen,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: hieghtSize * 0.03),
              Container(
                height: hieghtSize * 0.05,
                width: widthSize * 0.2,
                child: FloatingActionButton(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: ataaGreen,
                    child: Icon(Icons.done, color: ataaGold, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }
}
