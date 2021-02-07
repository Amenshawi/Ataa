import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:Ataa/HomePage.dart';

import 'login.dart';

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
  // 1= name card, 2= email card , 3= password card, 4= birthday selector
  int cardSelect = 1; 

  // text field state
  String error = '';

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
                  SizedBox(height: 50.0),
                  Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: Visibility(
                              visible: visibility,
                              child: Text(
                                error,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.redAccent),
                              ))),
                              SizedBox(height: 20),
                  // selector to determine which card to show
                  // name card
                  cardSelect == 1? inputcard(
                    fnameController, lnameController,
                    false, 'First Name', 'Last Name', 
                    Icon(Icons.person, color: Color.fromRGBO(28, 102, 74, 0.7))) : 
                  
                  //email card
                  cardSelect ==2? inputcard(
                    emailController, emailController2,
                    false, 'Email', 'Re-enter Email', 
                    Icon(Icons.email, color: Color.fromRGBO(28, 102, 74, 0.7))) :

                  //password card
                  cardSelect ==3? inputcard(
                    passwordController, passwordController2,
                    true, 'Password', 'Re-enter Password', 
                    Icon(Icons.vpn_key, color: Color.fromRGBO(28, 102, 74, 0.7))) :

                  //birthday card
                  cardSelect == 4? Card(
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
                          height: 20.0,
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
                          height: 120,
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
                  )
                  // closing the selection statement, cant be null so i used empty SizedBox
                  : SizedBox(),

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
                        checkCard(cardSelect);
                      },
                      child: Center(
                        heightFactor: 2.5,
                        child: Text(
                          cardSelect == 4?"Sign up":"Next",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(244, 234, 146, 1)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Color.fromRGBO(28, 102, 74, 1),
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap:() {
                        setState(() {
                          visibility = false;
                          error = '';
                          if(cardSelect == 1)
                            Navigator.pop(context);
                          else
                            cardSelect--;                          
                        });
                      },
                      child: Center(
                        heightFactor: 2.5,
                        child: Text('Back',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(244, 234, 146, 1)),
                        ),
                      ),
                    ),
                  ),
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
         try {
        visibility = false;
        dynamic result = await _auth.signupWithEmailAndPassword(
            emailController.text,
            passwordController.text,
            fnameController.text,
            lnameController.text,
            bday);
        _dialog(context, 'Confirmation', Color.fromRGBO(28, 102, 74, 1.0),
            'You Have Been Successfully Registered, Welcome to Ataa', 'Continue', true);
        print('test');
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (e) {
        print('by');
        _dialog(context, 'Error !', Color.fromRGBO(28, 102, 74, 1.0),
            'Sorry an error occured\n Error: ' + e.message, 'Try Again', false);
      }
      

  }
  checkCard(int selector){
    switch(selector){
      //checking name card input
      case 1:
      setState(() {
        if(fnameController.text.isEmpty || lnameController.text.isEmpty){
          visibility = true;
          error = 'Please Fill All Fields';
        }else {
          cardSelect++;
          visibility = false;
          error = '';
          }
        });
      break;

      // checking email card input
      case 2:
      setState(() {
      if(emailController.text.isEmpty || emailController2.text.isEmpty){
        visibility = true;
        error = 'Please Fill All Fields';
      }else if(!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)){
            visibility = true;
            error = 'Please Enter a Valid Email';
      }else if(emailController.text != emailController2.text){
        visibility = true;
        error = 'Emails Do Not Match';
      }else {
          cardSelect++;
          visibility = false;
          error = '';
          }
      });
      break;

      // checking password card input
      case 3:
       setState(() {
        if(passwordController.text.isEmpty || passwordController2.text.isEmpty){
          visibility = true;
          error = 'Please Fill All Fields';
        }else if(passwordController.text != passwordController2.text){
            visibility = true;
            error = 'Passwords Do Not Match';
        }else {
          cardSelect++;
          visibility = false;
          error = '';
          }
          });
      break;
      
      // checking birthday card input
      case 4:
      setState(() {
        if(calculateAge(bday) < 15){
          print('is underage');
          visibility = true;
          error = 'Age Must be 15 and Above';
        }else {
          signupClicked();
        }
      });
      break;
    }

  }
  
  void _dialog(context, String title, Color titleColor, String message,
      String buttonLabel, bool isDone) {
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
                  if (isDone) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    Navigator.pop(context);
                  }
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

  calculateAge(DateTime birthDate) {
    print("in the caclulate age method");
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
}