import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/auth.dart';
import 'package:flutter/cupertino.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: "Log In", home: SignupPage());
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var bday = DateTime(0000);
  String error = '';

  // text field state
  String email = '';
  String password = '';

  //implementing date picker method

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Sign up'),
        leading: FlatButton.icon(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20.0,
            color: Color.fromRGBO(251, 247, 239, 1.0),
          ),
          label: Text(''),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(28, 102, 74, 1),
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: fnameController,
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your First Name' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          controller: lnameController,
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'Last name',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Last Name' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(28, 102, 74, 1),
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'Enter email',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'Re-enter email',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(28, 102, 74, 1),
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Enter a Password' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            color: Color.fromRGBO(251, 247, 239, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 234, 146, 1))),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Color.fromRGBO(244, 234, 146, 0.8),
                            ),
                            labelText: 'Re-enter Password',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(244, 234, 146, 0.7)),
                          ),
                          textAlign: TextAlign.start,
                          validator: (val) =>
                              val.isEmpty ? 'Re-enter Your Password' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(28, 102, 74, 1),
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Select Your Birthday',
                          style: TextStyle(
                            color: Color.fromRGBO(244, 234, 146, 0.8),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 80,
                          child: CupertinoTheme(
                            child: CupertinoDatePicker(
                              backgroundColor: Color.fromRGBO(28, 102, 74, 0.3),
                              mode: CupertinoDatePickerMode.date,
                              minimumDate: DateTime(1930),
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              onDateTimeChanged: (DateTime newDateTime) {
                                bday = newDateTime;
                              },
                            ),
                            data: CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromRGBO(251, 247, 239, 1.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  /*RaisedButton(
                    shape: ShapeBorder.lerp(),
                    padding: EdgeInsets.fromLTRB(100.0,20.0,100.0,20.0),
                    color: Color.fromRGBO(28,102,74,1.0),
                    child: Text('Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                       if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signupWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                         }
                      }
                     }),*/
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Color.fromRGBO(28, 102, 74, 1),
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap: () async {
                        if (bday.year == 0000) {
                          // PRompt the user to choose a date
                        } else if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.signupWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                  fnameController.text,
                                  lnameController.text,
                                  bday);
                          // need to add the other user data to the database here.
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      },
                      child: Center(
                        heightFactor: 2.5,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(251, 247, 239, 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
