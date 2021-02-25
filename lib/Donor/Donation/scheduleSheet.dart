// import 'dart:io';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/database.dart';
// import 'package:Ataa/locationPage.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:date_range_picker/date_range_picker.dart';

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
  DateTime _dateTime;
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
              Container(
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
                          'Donation Type:  ',
                          style: TextStyle(fontSize: 18, color: ataaGreen),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          value: user.shirtSize,
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
                              // user.shirtSize = newValue;
                            });
                          },
                          items: <String>[
                            'Food',
                            'Clothes',
                            'Electronics',
                            'Devices'
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
              ),
              // Center(
              //   child: Text(_dateTime == null
              //       ? 'Nothintg has been selected'
              //       : _dateTime.toString()),
              // ),
              SizedBox(height: heightSize * 0.02),
              Container(
                height: heightSize * 0.07,
                width: widthSize * 0.75,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: ataaGreen,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, color: ataaGold),
                      SizedBox(width: widthSize * 0.03),
                      Text('Pick date ',
                          style: TextStyle(color: ataaGold, fontSize: 20)),
                    ],
                  ),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light().copyWith(
                                primary: ataaGreen,
                                onPrimary: ataaGold,
                              ),
                            ),
                            child: child,
                          );
                        }).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                ),
              ),
              SizedBox(height: heightSize * 0.02),
              Container(
                  height: heightSize * 0.07,
                  width: widthSize * 0.75,
                  child: Card(
                      color: ataaGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: ataaGold,
                            ),
                            hintText: _dateTime == null
                                ? 'Select a date'
                                : DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(_dateTime.toString())),
                            hintStyle:
                                TextStyle(color: ataaGold, fontSize: 20)),
                        readOnly: true,
                      ))),
              SizedBox(height: heightSize * 0.02),
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
                      // database.addDonation(user, type, _image,
                      //     descController.text, anonymous, location);
                      Navigator.pop(context);
                      // call db.addDonation here
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
