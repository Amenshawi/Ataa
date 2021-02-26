// import 'dart:io';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/database.dart';
import 'package:Ataa/locationPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

import 'package:image_picker/image_picker.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class CustomForm extends StatefulWidget {
  final String type;
  final AppUser user;
  final bool isFood;
  CustomForm(this.type, this.user, this.isFood);
  @override
  _CustomFormState createState() => _CustomFormState(type, user);
}

class _CustomFormState extends State<CustomForm> {
  final database = Database();
  PickedFile _image;
  double heightSize, widthSize;
  bool isSwitched = false;
  TextEditingController descController = TextEditingController();
  bool anonymous;
  bool imagePicked = false;
  LatLng location;
  final String type;
  final AppUser user;
  var time = 0;
  String placeHolder = 'now';
  _CustomFormState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return Container(
      width: widthSize,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ataaWhite,
        child: Padding(
          padding: EdgeInsets.only(
              top: heightSize * 0.04, bottom: heightSize * 0.04),
          child: Column(
            children: [
              // DottedBorder(
              //   dashPattern: [8, 4],
              //   color: ataaGreenField,
              //   strokeWidth: 2,
              //   borderType: BorderType.RRect,
              //   radius: Radius.circular(12),
              //   padding: EdgeInsets.all(6),
              //   child:
              //       // ClipRRect(
              //       //   borderRadius: BorderRadius.all(Radius.circular(12)),
              //       //   child:
              //       Column(children: [
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: heightSize * 0.07,
                  width: widthSize * 0.75,
                  child: Card(
                    color: ataaGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: !imagePicked
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                              // color: Colors.grey,
                              color: ataaGold,
                            ),
                            !imagePicked
                                ? Text(
                                    'Upload a Photo',
                                    style: TextStyle(
                                        color: ataaGold, fontSize: 20),
                                  )
                                : Text(''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              // Padding(
              //   padding: EdgeInsets.only(right: widthSize * 0.27),
              //   child: Text(
              //     'Description ',
              //     style: TextStyle(
              //         color: ataaGreen, fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              Container(
                height: heightSize * 0.12,
                width: widthSize * 0.75,
                child: Card(
                  color: ataaGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Descrption ',
                          //     style: TextStyle(color: ataaGreen, fontSize: 20)),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  color: ataaGold,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                              controller: descController,
                              cursorColor: ataaGold,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Descrption',
                                hintStyle:
                                    TextStyle(color: ataaGold, fontSize: 20),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // UnderlineInputBorder(
                                //     borderSide:
                                //         BorderSide(color: ataaGreen)
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                height: heightSize * 0.07,
                width: widthSize * 0.75,
                child: Card(
                  color: ataaGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      !isSwitched
                          ? Icon(Icons.visibility, color: ataaGold, size: 25)
                          : Icon(Icons.visibility_off,
                              color: ataaGold, size: 25),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text('Anonymous',
                            style: TextStyle(color: ataaGold, fontSize: 20)),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            anonymous = value;
                          });
                        },
                        activeTrackColor: ataaWhite,
                        activeColor: ataaGold,
                        inactiveThumbColor: ataaWhite,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                height: heightSize * 0.2,
                width: widthSize * 0.75,
                child: Card(
                  // color: ataaGreen,
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
                                    builder: (context) =>
                                        LocationPage(user, changeLocation)));
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
                              // fillColor: ataaGreen,
                              hintText: 'Location..',
                              hintStyle:
                                  TextStyle(color: ataaGreen, fontSize: 20)),
                        ),
                      ),
                      // Align(
                      //     // alignment: Alignment.center,
                      //     child:
                      Container(
                          height: heightSize * 0.14,
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
                      // )
                    ],
                  ),
                ),
              ),
              // ]),
              // ),
              // ),
              SizedBox(height: heightSize * 0.01),
              widget.isFood
                  ? Container(
                      height: heightSize * 0.07,
                      width: widthSize * 0.75,
                      child: Card(
                        color: ataaWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Notify Charities:  ',
                                style:
                                    TextStyle(fontSize: 18, color: ataaGreen),
                              ),
                            ),
                            Expanded(
                              child: DropdownButton(
                                value: time == 0
                                    ? 'now'
                                    : time.toString() + ' mins',
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: ataaGreen,
                                ),
                                iconSize: 20,
                                style: TextStyle(
                                    color: ataaGreen,
                                    // fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                // underline: Container(height: 2, color: ataaWhite),
                                onChanged: (String newValue) {
                                  setState(() {
                                    if (newValue == 'now') {
                                      time = 0;
                                    } else if (newValue == '5 mins') {
                                      time = 5;
                                    } else if (newValue == '10 mins') {
                                      time = 10;
                                    } else if (newValue == '15 mins') {
                                      time = 15;
                                    }
                                  });
                                },
                                items: <String>[
                                  'now',
                                  '5 mins',
                                  '10 mins',
                                  '15 mins'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(
                                            color: ataaGreen,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: heightSize * 0.03),
              Container(
                height: heightSize * 0.05,
                width: widthSize * 0.2,
                child: FloatingActionButton(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: ataaGreen,
                  child: Icon(Icons.done, color: ataaGold, size: 30),
                  onPressed: () {
                    print('Hi there!');
                    database.addDonation(user, type, _image,
                        descController.text, anonymous, location, time);
                    Navigator.pop(context);
                    // call db.addDonation here
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  changeLocation(LatLng _location) {
    setState(() {
      print('hi');
      this.location = _location;
    });
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      imagePicked = true;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
      imagePicked = true;
    });
  }
}
