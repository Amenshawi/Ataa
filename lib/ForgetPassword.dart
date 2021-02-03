import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .2,
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  labelText: 'Enter Your Email',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(28, 102, 74, 1))),
            ),
            SizedBox(height: 25),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color.fromRGBO(28, 102, 74, 1),
                      height: 40,
                      minWidth: 80,
                      child: Icon(
                        Icons.navigate_next,
                        color: Color.fromRGBO(244, 234, 146, 1),
                      ),
                      onPressed: () {
                        if (emailController.text == "") {
                          _dialog(
                              context,
                              "Ops!",
                              Color.fromRGBO(208, 161, 76, 1),
                              "You also forgot your email. Please provide your email!, so we can help you :)",
                              "Got It");
                        } else {
                          FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text);
                          emailController.text = "";
                          _dialog(
                              context,
                              "Confirmation",
                              Color.fromRGBO(208, 161, 76, 1),
                              "Yay! Great, Now please check your mailbox for a reset password email :)",
                              "Got It");
                        }
                      },
                    ))),
          ],
        ));
  }
}

void _dialog(context, String title, Color titleColor, String message,
    String buttonLabel) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Container(
      height: 250.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(color: titleColor, fontSize: 30.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              message,
              style: TextStyle(
                  color: Color.fromRGBO(28, 102, 74, 1), fontSize: 20),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 25.0)),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                buttonLabel,
                style: TextStyle(
                    color: Color.fromRGBO(28, 102, 74, 1), fontSize: 20),
              ))
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext bc) => errorDialog);
}
