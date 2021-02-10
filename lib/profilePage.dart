import 'dart:ui';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/auth.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/database.dart';
import 'package:page_transition/page_transition.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, 1);

class Profile extends StatefulWidget {
  final AppUser user;
  Profile(@required this.user);
  @override
  _ProfileState createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  double hieghtSize, widthSize;
  bool visiblePassword = false;
  bool isSwitched;
  Future<bool> private;
  List<bool> readWriteToggole = [true, true, true, true];
  List<bool> blurBackground = [false, false, false, false];
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  AppUser user;
  final database = Database();
  final _auth = AuthService();
  _ProfileState(this.user);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    private = database.getPrivacy(user);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Scaffold(
        body: FutureBuilder<bool>(
            future: private,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? SafeArea(child: profileContainer(snapshot.data))
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromRGBO(244, 234, 146, 1),
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromRGBO(28, 102, 74, 1)),
                      ),
                    );
            }));
  }

  Widget profileContainer(private) {
    if (isSwitched == null) {
      isSwitched = private;
    }
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
                    Icons.add,
                    Icons.check,
                    false,
                    'Location'), // based on the data from the db we can change the icon from add or change (if there is a location then the display icon would be edit and the oppsite).
                cardBlur(3, Icons.accessibility, 'Clothing Size', Icons.add,
                    Icons.check, false, "Clothes"), // same as card 3
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
                        mainAxisSize: MainAxisSize.max,
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
                                  right: widthSize * 0.33),
                              child: Text('Private Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ataaGreen,
                                      fontWeight: FontWeight.bold))),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched); // sorry guys lol!
                                database.changePrivacy(user, value);
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
                  changePassword(context);
                } else if (!blurBackground[index] ||
                    controllers[index].text == '') {
                  controllers[index].clear();
                  setState(() {
                    readWriteToggole[index] = !readWriteToggole[index];
                    blurBackground[index] = !blurBackground[index];
                  });
                } else if (index == 0) {
                  try {
                    print(controllers[0].text);
                    user = _auth.changeEmail(controllers[0].text, user);
                    setState(() {
                      readWriteToggole[index] = !readWriteToggole[index];
                      blurBackground[index] = !blurBackground[index];
                    });
                  } catch (error) {
                    print(error.toString);
                    //show error message
                  }
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

  Widget passwordSheet() {
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
                              // controller: emailController,
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
                              // controller: emailController,
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
                          // controller: emailController,
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
                        Navigator.pop(context);
                        await new Future.delayed(
                            const Duration(milliseconds: 200));
                      }
                      setState(() {
                        visiblePassword = !visiblePassword;
                        print('After call: ');
                        print(visiblePassword);
                      });
                    },
                  )),
            ],
          ));
    });
  }

  changePassword(context) {
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
              child: SingleChildScrollView(child: passwordSheet()));
        });
  }
}
