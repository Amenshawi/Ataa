import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import '../location_page.dart';
import 'package:toast/toast.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaRed = Color.fromRGBO(255, 88, 88, 1);

class AddLocationSheet extends StatefulWidget {
  String type;
  AddLocationSheet(this.type);
  @override
  _AddLocationSheetState createState() => _AddLocationSheetState(type);
}

class _AddLocationSheetState extends State<AddLocationSheet> {
  double hieghtSize, widthSize;
  bool private = false;
  LatLng location;
  String type;
  AppUser user;
  TextEditingController descController = TextEditingController();
  _AddLocationSheetState(this.type);
  void changeLocation(LatLng _location) {
    setState(() {
      this.location = _location;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);
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
                                        changeLocation)));
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
                        controller: descController,
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
                      try {
                        if (location == null) throw 'no location';
                        Database.addStand(
                            location, type, descController.text, user.uid);
                        showPopup('Charity stand has been added', false);
                      } catch (e) {
                        if (e == 'no location')
                          showPopup('Please add a location', true);
                      }
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }

  showPopup(String text, bool error) {
    Toast.show(text, context,
        border: Border(
          bottom:
              BorderSide(color: ataaWhite, width: 5, style: BorderStyle.solid),
          top: BorderSide(color: ataaWhite, width: 5, style: BorderStyle.solid),
          left:
              BorderSide(color: ataaWhite, width: 5, style: BorderStyle.solid),
          right:
              BorderSide(color: ataaWhite, width: 5, style: BorderStyle.solid),
        ),
        duration: 4,
        gravity: Toast.TOP,
        backgroundColor: ataaGreen,
        textColor: error ? ataaRed : ataaWhite,
        backgroundRadius: 10);

    if (!error) Navigator.pop(context);
  }
}
