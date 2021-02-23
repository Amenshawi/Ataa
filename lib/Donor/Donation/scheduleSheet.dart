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

class ScheduleSheet extends StatefulWidget {
  final String type;
  final AppUser user;
  ScheduleSheet(this.type, this.user);
  @override
  _ScheduleSheetState createState() => _ScheduleSheetState(type, user);
}

class _ScheduleSheetState extends State<ScheduleSheet> {
  final database = Database();
  double heightSize, widthSize;
  TextEditingController descController = TextEditingController();
  final String type;
  final AppUser user;
  _ScheduleSheetState(this.type, this.user);

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
                onTap: () {},
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
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                              // color: Colors.grey,
                              color: ataaGold,
                            ),
                            Text(
                              'Upload a Photo',
                              style: TextStyle(color: ataaGold, fontSize: 20),
                            )
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
                      Icon(Icons.visibility, color: ataaGold, size: 25),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text('Anonymous',
                            style: TextStyle(color: ataaGold, fontSize: 20)),
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
                          onTap: (() {}),
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

                      // )
                    ],
                  ),
                ),
              ),
              // ]),
              // ),
              // ),
              SizedBox(height: heightSize * 0.01),

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
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
