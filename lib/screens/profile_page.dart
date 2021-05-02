import 'dart:ui';
import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/services/database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:Ataa/screens/location_page.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);
final Color ataaRed = Color.fromRGBO(255, 88, 88, 1);

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController shoeSizeController = TextEditingController();

  double hieghtSize, widthSize;
  bool visiblePassword = false;
  bool isSwitched;
  Future<bool> private;
  List<bool> readWriteToggole = [true, true, true, true];
  List<bool> blurBackground = [false, false, false, false];

  var oldPasswordController = TextEditingController();

  var newPassword1Controller = TextEditingController();
  var newPassword2Controller = TextEditingController();

  var newEmail1Controller = TextEditingController();
  var newEmail2Controller = TextEditingController();

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final _auth = AuthService();

  LatLng currentPosition;
  bool foundLocation = false;
  GoogleMapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    if (user != null) {
      if (user.location == null) readWriteToggole[2] = false;
      if (user.pantSize == null &&
          user.shirtSize == null &&
          user.shoeSize == null) readWriteToggole[3] = false;
    }
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Scaffold(body: SafeArea(child: profileContainer()));
  }

  Widget profileContainer() {
    final user = Provider.of<AppUser>(context);
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          customBar(),
          SizedBox(height: hieghtSize * 0.04),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  // we can put a condition here if the user doesn't have a pic in the database, we will use his/her initails.
                  backgroundColor: ataaGreen,
                  child: Text(
                    user.fname[0] + user.lname[0],
                    style: TextStyle(color: ataaGold, fontSize: 30),
                  ),
                ),
                SizedBox(height: hieghtSize * 0.02),
                Text(
                  user.fname + ' ' + user.lname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: ataaGreen),
                ),
              ],
            ),
          ),
          Stack(children: [
            Center(
                child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                cardBlur(0, Icons.email, 'Email', Icons.edit, Icons.check,
                    false, user.email),
                cardBlur(1, Icons.vpn_key, 'Password', Icons.edit, Icons.check,
                    true, '******'),
                cardBlur(
                    2,
                    Icons.location_on,
                    'Add Location',
                    Icons.edit,
                    Icons.add,
                    false,
                    'Location'), // based on the data from the db we can change the icon from add or change (if there is a location then the display icon would be edit and the oppsite).
                cardBlur(3, Icons.accessibility, 'Clothing Size', Icons.edit,
                    Icons.add, false, ""), // same as card 3
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
                              child: user.privacy
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
                                  right: widthSize * 0.25),
                              child: Text('Private Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ataaGreen,
                                      fontWeight: FontWeight.bold))),
                          Switch(
                            value: user.privacy,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                Database.changePrivacy(user, value);
                              });
                            },
                            activeTrackColor: ataaGreen,
                            activeColor: ataaGold,
                          ),
                        ]),
                  ),
                )
              ]),
            )),
          ]),
        ]));
  }

  Widget cardBlur(
    int index,
    IconData prefixIcon,
    String label,
    IconData unpressedCornerIcon,
    IconData pressedCornerIcon,
    bool password,
    String pressedText,
  ) {
    return blurBackground[index]
        ? Visibility(
            visible: blurBackground[index],
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  card(index, prefixIcon, label, unpressedCornerIcon,
                      pressedCornerIcon, password, pressedText)
                ],
              ),
            ),
          )
        : card(index, prefixIcon, label, unpressedCornerIcon, pressedCornerIcon,
            password, pressedText);
  }

  Widget card(
      int index,
      IconData prefixIcon,
      String label,
      IconData unpressedCornerIcon,
      IconData pressedCornerIcon,
      bool password,
      String pressedText) {
    final user = Provider.of<AppUser>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 50,
      color: Color.fromRGBO(255, 255, 255, 0.75), // for now leave it at white
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: controllers[index],
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: ataaGreen),
              decoration: InputDecoration(
                labelText: label,
                hintText: pressedText,
                hintStyle: !blurBackground[index]
                    ? TextStyle(color: ataaGreen, fontSize: 23)
                    : TextStyle(color: Colors.grey, fontSize: 18),
                labelStyle: TextStyle(color: ataaGreen, fontSize: 20),
                prefixIcon: Icon(
                  prefixIcon,
                  color: ataaGreen,
                  size: 25,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              readOnly: readWriteToggole[index],
            ),
          ),
          Center(
            child: IconButton(
              icon: readWriteToggole[index]
                  ? Icon(
                      unpressedCornerIcon,
                      color: ataaGreen,
                      size: 25,
                    )
                  : Icon(
                      pressedCornerIcon,
                      color: ataaGreen,
                      size: 25,
                    ),
              onPressed: () {
                if (password) {
                  visiblePassword = false;
                  changePassword(context, user);
                } else if (index == 0) {
                  try {
                    visiblePassword = false;
                    changeEmail(context, user);
                  } catch (error) {
                    print(error.toString);
                    //show error message
                  }
                } else if ((index != 3 && index != 2) &&
                    (!blurBackground[index] || controllers[index].text == '')) {
                  controllers[index].clear();
                  setState(() {
                    readWriteToggole[index] = !readWriteToggole[index];
                    blurBackground[index] = !blurBackground[index];
                  });
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationPage(user, null)));
                } else if (index == 3) {
                  clothingCard(context, user.shoeSize, user.shirtSize,
                      user.pantSize, user);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.all(widthSize * .08),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: ataaGreen,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      SizedBox(width: widthSize * 0.07),
      Text(
        'Profile',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30, color: ataaGreen),
      ),
    ]);
  }

  Widget passwordSheet(AppUser user) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          height: MediaQuery.of(context).size.height * .4,
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                  child: visiblePassword
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: newPassword1Controller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  labelText: 'New Password',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ataaGreen)),
                            ),
                            TextField(
                              controller: newPassword2Controller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  labelText: 'Re-enter Password',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ataaGreen)),
                            ),
                          ],
                        )
                      : TextField(
                          controller: oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ataaGreen)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ataaGreen)),
                              labelText: 'Old Password',
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: ataaGreen)),
                        )),
              SizedBox(height: 25),
              Container(
                  padding: EdgeInsets.all(5),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: ataaGreen,
                    height: 40,
                    minWidth: 80,
                    child: Icon(
                      Icons.navigate_next,
                      color: ataaGold,
                    ),
                    onPressed: () async {
                      if (visiblePassword) {
                        var newPassword = newPassword1Controller.text;
                        var newPassword2 = newPassword2Controller.text;
                        if (newPassword == newPassword2) {
                          if (await _auth.changePassword(newPassword)) {
                            showPopup('password changed !', false);
                          } else {
                            showPopup(
                                'password too weak or error with the connection',
                                true);
                          }
                        } else {
                          showPopup('passwords don\'t match', true);
                        }
                      } else {
                        var correctPassword = await _auth.confirmPassword(
                            oldPasswordController.text, user);
                        if (correctPassword) {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        } else {
                          showPopup('wrong pawword', true);
                        }
                      }
                    },
                  )),
            ],
          ));
    });
  }

  changePassword(context, AppUser user) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 10,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
              child: SingleChildScrollView(child: passwordSheet(user)));
        });
    oldPasswordController = TextEditingController();
  }

  clothingCard(
      context, int shoeSize, String shirtSize, String pantSize, AppUser user) {
    if (shoeSize != null) shoeSizeController.text = shoeSize.toString();
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 10,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
              child: SingleChildScrollView(
                  child: clothingSheet(shoeSize, shirtSize, pantSize, user)));
        });
  }

  Widget clothingSheet(
      int shoeSize, String shirtSize, String pantSize, AppUser user) {
    bool error = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          height: MediaQuery.of(context).size.height * .4,
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                    child: Column(
                  children: [
                    Visibility(
                      visible: error,
                      child: Text(
                        'Please Enter a Valid Shoe Size',
                        style: TextStyle(fontSize: 26, color: Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Shirts/Tshirts',
                              style: TextStyle(
                                  color: ataaGreen,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Pants',
                              style: TextStyle(
                                  color: ataaGreen,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Shoe Size',
                              style: TextStyle(
                                  color: ataaGreen,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            DropdownButton(
                              value: shirtSize,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 22,
                              style: TextStyle(
                                  color: ataaGold,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              underline: Container(height: 2, color: ataaGreen),
                              onChanged: (String newValue) {
                                setState(() {
                                  shirtSize = newValue;
                                });
                              },
                              items: <String>[
                                'XS',
                                'S',
                                'M',
                                'L',
                                'XL',
                                'XXL',
                                'XXXL'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: ataaGreen,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 30),
                            DropdownButton(
                              value: pantSize,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 22,
                              style: TextStyle(
                                  color: ataaGold,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              underline: Container(height: 2, color: ataaGreen),
                              onChanged: (String newValue) {
                                setState(() {
                                  print(newValue);
                                  pantSize = newValue;
                                });
                              },
                              items: <String>[
                                'XS',
                                'S',
                                'M',
                                'L',
                                'XL',
                                'XXL',
                                'XXXL'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: ataaGreen,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: TextField(
                                maxLines: 1,
                                maxLength: 2,
                                maxLengthEnforced: true,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              28, 102, 74, 0.7))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(28, 102, 74, 1.0),
                                          width: 3.0)),
                                ),
                                controller: shoeSizeController,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: ataaGreen,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: ataaGreen,
                          height: 50,
                          minWidth: 120,
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: ataaGold,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            int temp = int.tryParse(shoeSizeController.text);
                            if (shoeSizeController.text.isNotEmpty) {
                              if (temp == null ||
                                  int.tryParse(shoeSizeController.text) <= 5 ||
                                  int.tryParse(shoeSizeController.text) >= 55) {
                                error = true;
                              } else {
                                error = false;
                              }
                            } else {
                              error = false;
                            }
                            if (!error) {
                              Navigator.pop(context);
                              await Database.updateClothesSizes(
                                  shirtSize, pantSize, temp, user);
                            } else
                              setState(() {
                                error = true;
                              });
                          },
                        )),
                  ],
                ))
              ],
            ),
          ));
    });
  }

  Widget emailSheet(AppUser user) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          height: MediaQuery.of(context).size.height * .4,
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                  child: visiblePassword
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: newEmail1Controller,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  labelText: 'New email',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ataaGreen)),
                            ),
                            TextField(
                              controller: newEmail2Controller,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ataaGreen)),
                                  labelText: 'Re-enter email',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ataaGreen)),
                            ),
                          ],
                        )
                      : TextField(
                          controller: oldPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ataaGreen)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: ataaGreen)),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: ataaGreen)),
                        )),
              SizedBox(height: 25),
              Container(
                  padding: EdgeInsets.all(5),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: ataaGreen,
                    height: 40,
                    minWidth: 80,
                    child: Icon(
                      Icons.navigate_next,
                      color: ataaGold,
                    ),
                    onPressed: () async {
                      if (visiblePassword) {
                        var newEmail1 = newEmail1Controller.text;
                        var newEmail2 = newEmail2Controller.text;
                        if (newEmail1 == newEmail2) {
                          if (await _auth.changeEmail(newEmail1, user)) {
                            showPopup('Email changed', false);
                          } else {
                            showPopup(
                                'Email inavild or error with the connection',
                                true);
                          }
                        } else {
                          showPopup('emails don\'t match', true);
                        }
                      } else {
                        var correctPassword = await _auth.confirmPassword(
                            oldPasswordController.text, user);
                        if (correctPassword) {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        } else {
                          showPopup('wrong pawword', true);
                        }
                      }
                    },
                  )),
            ],
          ));
    });
  }

  changeEmail(context, AppUser user) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 10,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
              child: SingleChildScrollView(child: emailSheet(user)));
        });
    oldPasswordController = TextEditingController();
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
