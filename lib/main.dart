import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Just a demo",
        home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 220, left: 110),
                child: Text(
                  'HELLO THERE!',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 400),
                // alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 100.0,
                  color: Colors.lightGreen,
                  shadowColor: Colors.grey,
                  child: Column(children: [
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen)),
                        prefixIcon: Icon(Icons.person),
                        labelText: "USERNAME",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen)),
                        prefixIcon: Icon(Icons.vpn_key),
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 200.0),
                      child: InkWell(
                        child: Text("Forgot Password",
                            style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    )
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 620.0),
                // alignment: Alignment.bottomCenter,
                // height: 100.0,
                margin: EdgeInsets.all(10.0),
                child: Column(children: [
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Colors.lightGreen,
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        heightFactor: 3.0,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Colors.lightGreen,
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        heightFactor: 3.0,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
