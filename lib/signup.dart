import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
  var emailController2 = TextEditingController();
  var passwordController = TextEditingController();
  var passwordController2 = TextEditingController();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  DateTime bday = DateTime.now();
  var visibility = false;

  // text field state
  String error = '';

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
                  Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: Visibility(
                              visible: visibility,
                              child: Text(
                                error,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.redAccent),
                              ))),
                  SizedBox(height: 5.0),
                  // name card
                  inputcard(
                    fnameController, lnameController,
                    false, 'First Name', 'Last Name', 
                    Icon(Icons.person, color: Color.fromRGBO(28, 102, 74, 0.7))),

                  SizedBox(height: 5.0),
                // email card
                 inputcard(
                    emailController, emailController2,
                    false, 'Email', 'Re-enter Email', 
                    Icon(Icons.email, color: Color.fromRGBO(28, 102, 74, 0.7))),

                  SizedBox(
                    height: 5.0,
                  ),
                  //password card
                  inputcard(
                    passwordController, passwordController2,
                    true, 'Password', 'Re-enter Password', 
                    Icon(Icons.vpn_key, color: Color.fromRGBO(28, 102, 74, 0.7))),

                  SizedBox(
                    height: 5.0,
                  ),
                  //Date picker
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                        side: BorderSide(
                          color: Color.fromRGBO(28,102,74,1.0), 
                          width: 5.0, 
                          style: BorderStyle.solid)),
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Select Your Birthday',
                          style: TextStyle(
                            color: Color.fromRGBO(28,102,74,1.0),
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
                              backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
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
                                  color: Color.fromRGBO(28,102,74,1.0),
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
                  // signup button
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Color.fromRGBO(28, 102, 74, 1),
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap:() {
                        signupClicked();
                        },
                      child: Center(
                        heightFactor: 2.5,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(244, 234, 146, 1)),
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
   // Creating the form input cards
  inputcard(topController, bottomController, bool passwordCard, String topLabel, String bottomLabel, Icon icon){
    return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(28,102,74,1.0), 
                style: BorderStyle.solid,
                width: 5.0 ),
              borderRadius: BorderRadius.circular(20)),
              color: Color.fromRGBO(255, 255, 255, 1),
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  TextField(
                    obscureText: passwordCard,
                    controller: topController,
                    style: TextStyle(
                      color: Color.fromRGBO(28,102,74,1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    decoration:InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(28, 102, 74, 0.7))),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(28, 102, 74, 1.0), width: 3.0)),
                      prefixIcon: icon,
                      labelText: topLabel,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(28, 102, 74, 0.7)),
                      ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    obscureText: passwordCard,
                    controller: bottomController,
                      style: TextStyle(
                        color: Color.fromRGBO(28,102,74,1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      decoration:InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: icon,
                        labelText: bottomLabel,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(28, 102, 74, 0.7)),
                        ),
                        textAlign: TextAlign.start,
                        ),
                    ],),
                  );
  }
  signupClicked() async{
    // no field is empty
    if(fnameController.text.isEmpty || lnameController.text.isEmpty ||
      emailController.text.isEmpty || emailController2.text.isEmpty ||
      passwordController.text.isEmpty || passwordController2.text.isEmpty){
        setState(() {
          visibility = true;
          error = 'Please Fill All Fields';
        });
        // emails match
      }else if(emailController.text != emailController2.text ){
          setState(() {
            visibility = true;
            error = 'Emails Do Not Match';
          });
        // passwords match
       }else if(passwordController.text != passwordController2.text){
         setState(() {
            visibility = true;
            error = 'Passwords Do Not Match';
          });
        // age is 15+
       }else if(!bday.isBefore(DateTime.now().subtract(const Duration(days: 5474)))){
         setState(() {
            visibility = true;
            error = 'Age Must be 15 and Above';
          });
      }else{
        try{
          dynamic result =
          await _auth.signupWithEmailAndPassword(
            emailController.text,
            passwordController.text,
            fnameController.text,
            lnameController.text,
            bday);
        }on FirebaseAuthException catch (e){
        }
      } 
  }
}