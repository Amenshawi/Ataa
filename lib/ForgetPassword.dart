import 'package:Ataa/main.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String textFieldLabel_One = "Enter Your Email";
  String textFieldLabel_Two = "Re-enter Password:";

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .5,
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  labelText: textFieldLabel_One,
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(28, 102, 74, 1))),
            ),
            Visibility(
              visible: isVisible,
              child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(28, 102, 74, 1))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(28, 102, 74, 1))),
                        labelText: textFieldLabel_Two,
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(28, 102, 74, 1))),
                  )),
            ),
            SizedBox(height: 80),
            Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.grey,
              color: Color.fromRGBO(28, 102, 74, 1),
              elevation: 100.0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (textFieldLabel_One == "Enter Your Email") {
                        textFieldLabel_One = "Enter The send code";
                      } else if (textFieldLabel_One == "Enter The send code") {
                        isVisible = true;
                        textFieldLabel_One = "New Password: ";
                      } else {
                        print("i was pressed three times dude!");
                      }
                    });
                  },
                  // onDoubleTap: () {
                  //   setState(() {});
                  // },
                  child: Center(
                    heightFactor: 2.0,
                    child: Icon(
                      Icons.navigate_next,
                      color: Color.fromRGBO(244, 234, 146, 1),
                    ),
                  )),
            )
          ],
        ));
  }
}
