import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/models/donation_request.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';
import '../location_page.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);

class ReqForm extends StatefulWidget {
  @override
  _ReqFormState createState() => _ReqFormState();
}

class _ReqFormState extends State<ReqForm> {
  double hieghtSize, widthSize;
  bool private = false;
  bool isSwitched = false;
  LatLng location;
  String selectedType = 'food';
  final types = ['food', 'clothes', 'electronics', 'furniture'];
  String selectedImportance = 'High';
  final importance = ['high', 'medium', 'low'];
  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return reqDonation(user);
  }

  Widget reqDonation(AppUser user) {
    return Container(
      width: widthSize,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: hieghtSize * 0.02, bottom: hieghtSize * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: widthSize * 0.05,
                  ),
                  Text(
                    'Type',
                    style: TextStyle(
                        color: ataaGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: hieghtSize * 0.1,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 50,
                  color: Color.fromRGBO(255, 255, 255, 0.75),
                  child: Container(
                    height: hieghtSize * 0.09,
                    child: CupertinoPicker(
                      looping: true,
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        selectedType = types[value];
                      },
                      children: [
                        Text(
                          'food',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'clothes',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'electronics',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'furniture',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hieghtSize * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: widthSize * 0.05,
                  ),
                  Text(
                    'Importance',
                    style: TextStyle(
                        color: ataaGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: hieghtSize * 0.1,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 50,
                  color: Color.fromRGBO(255, 255, 255, 0.75),
                  child: Container(
                    height: hieghtSize * 0.09,
                    child: CupertinoPicker(
                      looping: true,
                      itemExtent: 30,
                      onSelectedItemChanged: (value) {
                        selectedImportance = importance[value];
                      },
                      children: [
                        Text(
                          'high',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'medium',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'low',
                          style: TextStyle(
                              color: ataaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hieghtSize * 0.01,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 50,
                color: Color.fromRGBO(
                    255, 255, 255, 0.75), // for now leave it at white !
                child: Padding(
                  padding: EdgeInsets.only(
                      top: hieghtSize * 0.01, left: widthSize * 0.02),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(widthSize * 0.02),
                            child: !private
                                ? Icon(
                                    Icons.visibility,
                                    size: 25,
                                    color: ataaGreen,
                                  )
                                : Icon(Icons.visibility_off,
                                    size: 25, color: ataaGreen)),
                        Padding(
                            padding: EdgeInsets.only(
                                top: hieghtSize * 0.009,
                                right: widthSize * 0.3),
                            child: Text('Anonimity',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ataaGreen,
                                    fontWeight: FontWeight.bold))),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = !isSwitched;
                              private = !private;
                            });
                          },
                          activeTrackColor: ataaGreen,
                          activeColor: ataaGold,
                        ),
                      ]),
                ),
              ),
              SizedBox(height: hieghtSize * 0.01),
              !isSwitched
                  ? Container(
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
                                              user, changeLocation)));
                                }),
                                readOnly: true,
                                cursorColor: ataaGreen,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ataaGreen)),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      size: 25,
                                      color: ataaGreen,
                                    ),
                                    hintText: 'Location..',
                                    hintStyle: TextStyle(
                                        color: ataaGreen, fontSize: 20)),
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
                    )
                  : Container(),
              SizedBox(height: hieghtSize * 0.02),
              Center(
                child: Container(
                  height: hieghtSize * 0.05,
                  width: widthSize * 0.2,
                  child: FloatingActionButton(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: ataaGreen,
                      child: Icon(Icons.done, color: ataaGold, size: 30),
                      onPressed: () {
                        final request = DonationRequest(
                            type: selectedType,
                            user: user,
                            location: location,
                            anonymous: private,
                            importance: selectedImportance);
                        Database.addDonationRequest(request);
                        Navigator.pop(context);
                      }),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  changeLocation(LatLng _location) {
    setState(() {
      this.location = _location;
    });
  }
}
