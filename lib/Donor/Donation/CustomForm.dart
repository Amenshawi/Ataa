// import 'dart:io';
import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class CustomForm extends StatefulWidget {
  final String type;
  CustomForm(this.type);
  @override
  _CustomFormState createState() => _CustomFormState(type);
}

class _CustomFormState extends State<CustomForm> {
  // File _image;
  double heightSize, widthSize;
  bool isSwitched = false;
  String type;
  _CustomFormState(this.type);
  // Future getImage() async {
  //   PickedFile pickedFile = await ImagePicker.getImage(
  //       source: ImageSource.camera, imageQuality: 50);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return Container(
      width: widthSize * 0.9,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ataaGreen,
        child: Padding(
          padding: EdgeInsets.all(heightSize * 0.04),
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
                  print('Hi there!');
                },
                child: Container(
                  height: heightSize * 0.07,
                  width: widthSize * 0.6,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                              // color: Colors.grey,
                              color: ataaGreen,
                            ),
                            Text(
                              'Upload a Photo',
                              style: TextStyle(color: ataaGreen, fontSize: 20),
                            ),
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
                width: widthSize * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descrption ',
                              style: TextStyle(color: ataaGreen, fontSize: 20)),
                          Expanded(
                            child: TextField(
                              cursorColor: ataaGreen,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ataaGreen))),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                height: heightSize * 0.07,
                width: widthSize * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      !isSwitched
                          ? Icon(Icons.visibility, color: ataaGreen, size: 25)
                          : Icon(Icons.visibility_off,
                              color: ataaGreen, size: 25),
                      Text('Anonymous',
                          style: TextStyle(color: ataaGreen, fontSize: 20)),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            // database.changePrivacy(user, value);
                          });
                        },
                        activeTrackColor: ataaGreen,
                        activeColor: ataaGold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                height: heightSize * 0.2,
                width: widthSize * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: ataaGreen,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
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
                      Align(
                          alignment: Alignment.center,
                          child: Text('Map goes here!'))
                    ],
                  ),
                ),
              ),
              // ]),
              // ),
              // ),
              SizedBox(
                height: heightSize * 0.03,
              ),
              Container(
                height: heightSize * 0.05,
                width: widthSize * 0.2,
                child: FloatingActionButton(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                  child: Icon(Icons.done, color: ataaGreen, size: 30),
                  onPressed: () {
                    print('Hi there!');
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
}
